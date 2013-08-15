package maryfisher.framework.core {
	import flash.utils.Dictionary;
	import maryfisher.framework.command.asset.InitAssetCommand;
	import maryfisher.framework.command.asset.LoadAssetCommand;
	import maryfisher.framework.command.CommandSequencer;
	import maryfisher.framework.command.loader.LoaderCommand;
	import maryfisher.framework.command.view.LoadingProgress;
	import maryfisher.framework.data.AssetData;
	import maryfisher.framework.data.LoaderData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AssetController {
		
		static private var _instance:AssetController;
		
		private var _mapping:Dictionary;
		private var _cachedAssets:Dictionary;
		
		private var _paths:Dictionary; /* loaderid => LoaderData */
		
		protected var _activeLoader:Vector.<LoaderCommand>;
		/* TODO
		 * these are not in use as of yet
		 */
		protected var _queuedLoader:Vector.<LoaderCommand>;
		protected var _prioritizedLoader:Vector.<LoaderCommand>;
		protected var _cachedLoadedAssets:Dictionary;
		
		public function AssetController() {
			
			_cachedAssets = new Dictionary();
			_cachedLoadedAssets = new Dictionary();
			_activeLoader = new Vector.<LoaderCommand>();
		}
		
		static public function getInstance():AssetController {
			if (!_instance) {
				_instance = new AssetController();
				
			}
			return _instance;
		}
		//static public function init(mapping:Dictionary):void {
			//getInstance()._mapping = mapping;
			//
		//}
		
		static public function registerAssetCommand(cmd:LoadAssetCommand):void {
			_instance.executeAssetCommand(cmd);
		}
		
		public function executeAssetCommand(cmd:LoadAssetCommand):void {
			var obj:*;
			if (_cachedAssets[cmd.id + cmd.fileId] == null) {
				var asData:AssetData = _mapping[cmd.id];
				if (!asData) {
					cmd.loadAsset();
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
		
		static public function init(paths:Dictionary, mapping:Dictionary, loadingScreenPath:String = null):void {
			getInstance()._paths = paths;
			getInstance()._mapping = mapping;
			
			if (loadingScreenPath) {
				//new LoadAssetCommand(loadingScreenPath, _instance);
			}
		}
		
		private function executeLoaderCommand(cmd:LoaderCommand):void {
			/* TODO
			 * _activeLoader nach Prio ordnen
			 * nach Tick loaden
			 */
			
			if (_cachedLoadedAssets[cmd.id + cmd.fileId] != null) {
				cmd.asset = _cachedLoadedAssets[cmd.id + cmd.fileId];
				cmd.setFinished();
				return;
			}
			
			//if (cmd is LoadAssetCommand) {
				//var loaderData:LoaderData = _paths[cmd.id];
				//var lcmd:LoaderCommand = new loaderData.type(cmd.id, cmd.priority);
				//var lcmd:LoaderCommand = new AssetLoaderCommand(cmd.id, cmd.fileId, cmd.priority);
				//lcmd.finishedLoading.addOnce(cmd.leachLoading);
				//return;
			//}
			
			if (isLoading(cmd)) {
				return;
			}
			
			_activeLoader.push(cmd);
			
			//cmd.percentLoading.add(setPercent);
			if ((_paths[cmd.id] as LoaderData).description) {
				new LoadingProgress(cmd, _paths[cmd.id]);
			}
			cmd.finishedLoading.addOnce(finishedLoading);
			cmd.loadAsset(_paths[cmd.id]);
			//_loaderView && _loaderView.show();
		}
		
		public function unloadAsset(id:String):void {
			_cachedLoadedAssets[id] = null;
		}
		
		private function isLoading(cmd:LoaderCommand):Boolean {
			/* TODO
			 * _activeLoader zu einem Dictionary machen, so dass schneller id gefunden wird
			 */
			for each(var lcmd:LoaderCommand in _activeLoader) {
				if (lcmd.id == cmd.id && lcmd.fileId == cmd.fileId) {
					lcmd.finishedLoading.addOnce(cmd.leachLoading);
					return true;
				}
			}
			
			return false;
		}
		
		
		protected function finishedLoading(cmd:LoaderCommand):void {
			
			_activeLoader.splice(_activeLoader.indexOf(cmd), 1);
			if (cmd.loaderData.doCache) {
				_cachedLoadedAssets[cmd.id + cmd.fileId] = cmd.asset;
			}
			
			//if (_activeLoader.length == 0) {
				//_loaderView && _loaderView.hide();
			//}
		}
		
		//protected function setPercent(cmd:LoaderCommand):void{
			//
			//var percent:Number = 0;
			//for each(var cmd:LoaderCommand in _activeLoader) {
				//percent += cmd.percent;
			//}
			//percent = percent / _activeLoader.length;
			//_loaderView && _loaderView.changePercent(percent);
		//}
		
		static public function registerLoaderCommand(cmd:LoaderCommand):void {
			_instance.executeLoaderCommand(cmd);
		}
		
		static public function registerSequence(sequence:CommandSequencer):void {
			
		}
		
	}

}