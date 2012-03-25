package maryfisher.framework.core {
	import flash.utils.Dictionary;
	import maryfisher.framework.command.CommandSequencer;
	import maryfisher.framework.command.loader.AssetLoaderCommand;
	import maryfisher.framework.command.IViewLoadingCallback;
	import maryfisher.framework.command.loader.LoaderCommand;
	import maryfisher.framework.command.LoadViewCommand;
	import maryfisher.framework.command.view.LoadingProgress;
	import maryfisher.framework.data.LoaderData;
	import maryfisher.framework.view.ILoaderView;
	
	/**
	 *
	 * @author mary_fisher
	 */
	public class LoaderController {
		
		static private var _instance:LoaderController;
		
		private var _paths:Dictionary; /* loaderid => LoaderData */
		
		protected var _activeLoader:Vector.<LoaderCommand>;
		/* TODO
		 * these are not in use as of yet
		 */
		protected var _queuedLoader:Vector.<LoaderCommand>;
		protected var _prioritizedLoader:Vector.<LoaderCommand>;
		protected var _cachedAssets:Dictionary;
		
		public function LoaderController() {
			_activeLoader = new Vector.<LoaderCommand>();
			_queuedLoader = new Vector.<LoaderCommand>();
			_prioritizedLoader = new Vector.<LoaderCommand>();
			
			_cachedAssets = new Dictionary();
		}
		
		static public function getInstance():LoaderController {
			if (!_instance) {
				_instance = new LoaderController();
				
			}
			return _instance;
		}
		
		static public function init(paths:Dictionary, loadingScreenPath:String = null):void {
			getInstance()._paths = paths;
			
			if (loadingScreenPath) {
				//new LoadViewCommand(loadingScreenPath, _instance);
			}
		}
		
		public function set loaderCommand(cmd:LoaderCommand):void {
			/* TODO
			 * _activeLoader nach Prio ordnen
			 * nach Tick loaden
			 */
			
			if (_cachedAssets[cmd.fileId] != null) {
				cmd.asset = _cachedAssets[cmd.fileId];
				return;
			}
			
			//if (cmd is LoadViewCommand) {
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
			new LoadingProgress(cmd, _paths[cmd.id]);
			cmd.finishedLoading.addOnce(finishedLoading);
			cmd.loadAsset(_paths[cmd.id]);
			//_loaderView && _loaderView.show();
		}
		
		public function unloadAsset(id:String):void {
			_cachedAssets[id] = null;
		}
		
		private function isLoading(cmd:LoaderCommand):Boolean {
			/* TODO
			 * _activeLoader zu einem Dictionary machen, so dass schneller id gefunden wird
			 */
			for each(var lcmd:LoaderCommand in _activeLoader) {
				if (lcmd.fileId == cmd.fileId) {
					lcmd.finishedLoading.addOnce(cmd.leachLoading);
					return true;
				}
			}
			
			return false;
		}
		
		
		protected function finishedLoading(cmd:LoaderCommand):void {
			
			_activeLoader.splice(_activeLoader.indexOf(cmd), 1);
			if (cmd.loaderData.doCache) {
				_cachedAssets[cmd.fileId] = cmd.asset;
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
		
		static public function registerCommand(cmd:LoaderCommand):void {
			_instance.loaderCommand = cmd;
		}
		
		static public function registerSequence(sequence:CommandSequencer):void {
			
		}
	}
}