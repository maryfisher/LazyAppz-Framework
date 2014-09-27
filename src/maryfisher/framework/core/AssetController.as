package maryfisher.framework.core {
	import flash.utils.Dictionary;
	import maryfisher.framework.command.asset.LoadAssetCommand;
	import maryfisher.framework.command.loader.LoaderCommand;
	import maryfisher.framework.command.view.LoadingProgress;
	import maryfisher.framework.data.AssetData;
	import maryfisher.framework.data.LoaderData;
	import maryfisher.framework.util.ErrorUtil;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AssetController {
		
		static private var _instance:AssetController;
		
		private var _mapping:Dictionary; /* loaderid => AssetData */
		private var _cachedAssets:Dictionary;
		
		private var _paths:Dictionary; /* loaderid => LoaderData */
		private var _cachedLoadedAssets:Dictionary;
		
		private var _activeLoader:Vector.<LoaderCommand>;
		/* TODO
		 * these are not in use as of yet
		 */
		private var _queuedLoader:Vector.<LoaderCommand>;
		private var _prioritizedLoader:Vector.<LoaderCommand>;
		
		public function AssetController() {
			
			_cachedAssets = new Dictionary();
			_cachedLoadedAssets = new Dictionary();
			_activeLoader = new Vector.<LoaderCommand>();
			_queuedLoader = new Vector.<LoaderCommand>();
			_prioritizedLoader = new Vector.<LoaderCommand>();
		}
		
		static public function getInstance():AssetController {
			if (!_instance) {
				_instance = new AssetController();
				
			}
			return _instance;
		}
		
		static public function registerAssetCommand(cmd:LoadAssetCommand):void {
			_instance.executeAssetCommand(cmd);
		}
		
		public function executeAssetCommand(cmd:LoadAssetCommand):void {
			var obj:*;
			if (_cachedAssets[cmd.id + cmd.fileId] == null) {
				var asData:AssetData = _mapping[cmd.id];
				if (!asData || asData.load) {
					cmd.loadAsset(asData);
					return;
				}else {
					obj = new asData.assetClass();
					if(asData.cacheAsset){
						_cachedAssets[cmd.id + cmd.fileId] = obj;
					}
				}
			}
			
			cmd.buildAsset(obj);
		}
		
		static public function init(paths:Dictionary, mapping:Dictionary):void {
			getInstance()._paths = paths;
			getInstance()._mapping = mapping;
			
		}
		
		private function executeLoaderCommand(cmd:LoaderCommand):void {
			/* TODO
			 * sort _activeLoader by priority
			 * load by tick
			 */
			
			if (_cachedLoadedAssets[cmd.id + cmd.fileId] != null) {
				cmd.asset = _cachedLoadedAssets[cmd.id + cmd.fileId];
				cmd.setFinished();
				return;
			}
			
			if (isLoading(cmd)) {
				return;
			}
			
			_activeLoader.push(cmd);
			
			var ld:LoaderData = (_paths[cmd.id] as LoaderData);
			if (!ld) {
				ErrorUtil.somethingWrong("No LoaderData found for assetId " + cmd.id, "AssetController", "executeLoaderCommand");
				return;
			}
			
			if (ld.description) {
				new LoadingProgress(cmd, ld);
			}
			cmd.finishedLoading.addOnce(finishedLoading);
			cmd.loadAsset(ld);
		}
		
		public function unloadAsset(id:String):void {
			_cachedLoadedAssets[id] = null;
			_cachedAssets[id] = null;
		}
		
		private function isLoading(cmd:LoaderCommand):Boolean {
			/* TODO
			 * _activeLoader as dictionary?
			 */
			for each(var lcmd:LoaderCommand in _activeLoader) {
				if (lcmd.id == cmd.id && lcmd.fileId == cmd.fileId) {
					lcmd.finishedLoading.addOnce(cmd.leachLoading);
					return true;
				}
			}
			
			return false;
		}
		
		private function finishedLoading(cmd:LoaderCommand):void {
			
			_activeLoader.splice(_activeLoader.indexOf(cmd), 1);
			if (cmd.loaderData.cacheClass) {
				_cachedLoadedAssets[cmd.id + cmd.fileId] = cmd.cacheAsset;
			}
		}
		
		static public function registerLoaderCommand(cmd:LoaderCommand):void {
			_instance.executeLoaderCommand(cmd);
		}
		
		static public function getLoaderData(id:String):LoaderData {
			return _instance._paths[id];
		}
		
	}

}