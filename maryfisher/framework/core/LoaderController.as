package maryfisher.framework.core {
	import maryfisher.framework.command.loader.AssetLoaderCommand;
	import maryfisher.framework.command.loader.ILoaderCommandReceiver;
	import maryfisher.framework.command.loader.LoaderCommand;
	import maryfisher.framework.command.loader.WindowLoaderCommand;
	import maryfisher.framework.command.view.ViewCommand;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import maryfisher.framework.core.ILoaderView;
	/**
	 * initial Loading?? über Event, auf das der GameController horcht und dann den 
	 * activityController initialisiert?
	 * kann dann auch neu gemacht werden, wenn GameMenu load/new
	 * @author mary_fisher
	 */
	public class LoaderController implements ILoaderCommandReceiver {
		
		protected var _activeLoader:Vector.<LoaderCommand>;
		protected var _loaderView:ILoaderView;
		protected var _cachedAssets:Dictionary;
		
		public function LoaderController() {
			
		}
		
		public function init():void {
			_activeLoader = new Vector.<LoaderCommand>();
			//_loaderView = new LoaderView();
			_cachedAssets = new Dictionary();
			//CommandController.registerForLoaderCommand(this);
			new ViewCommand(_loaderView);
		}
		
		public function set loaderCommand(cmd:LoaderCommand):void {
			/* TODO
			 * when finished irgendetwas speichern: Class/XML
			 * _activeLoader nach Prio ordnen
			 */
			//trace('start loading ...');
			if(_cachedAssets[cmd.id] == null){
				
				if (!isLoading(cmd)) {
					_loaderView.show();
					_activeLoader.push(cmd);
					cmd.percentLoading.add(setPercent);
					cmd.finishedLoading.addOnce(finishedLoading);					
					cmd.loadAsset();
				}
				
				
			}else {
				cmd.asset = _cachedAssets[cmd.id];
				//if (cmd is AssetLoaderCommand) {
					//(cmd as AssetLoaderCommand).assetLoaderCommand = _cachedAssets[cmd.id]
					//(cmd as AssetLoaderCommand).assetDomain = _cachedAssets[cmd.id]
					//cmd.setFinished();
				//}else{
					
				//}
			}
		}
		
		private function isLoading(cmd:LoaderCommand):Boolean {
			for each(var lcmd:LoaderCommand in _activeLoader) {
				if (lcmd.id == cmd.id) {
					lcmd.finishedLoading.addOnce(cmd.leachLoading);
					return true;
				}
			}
			
			return false;
		}
		
		
		protected function finishedLoading(cmd:LoaderCommand):void {
			_activeLoader.splice(_activeLoader.indexOf(cmd), 1);
			//trace('finish loading _activeLoader.length ' + _activeLoader.length);
			if (_activeLoader.length == 0) _loaderView.hide();
			//if (!(cmd is WindowLoaderCommand)) {
				//var cl:Class = getDefinitionByName(getQualifiedClassName((cmd as WindowLoaderCommand).asset)) as Class;
				//_cachedAssets[cmd.id] = cl;
			//}else 
			//if (cmd is AssetLoaderCommand) {
				if (cmd.doCache) {
					//_cachedAssets[cmd.id] = cmd;
					_cachedAssets[cmd.id] = cmd.asset;
				}
			//}
		}
		
		protected function setPercent(cmd:LoaderCommand):void{
			/* TODO
			 * progress anzeigen
			 */
			
			var percent:Number = 0;
			for each(var cmd:LoaderCommand in _activeLoader) {
				//trace('percent ' + cmd.percent , cmd);
				percent += cmd.percent;
			}
			percent = percent / _activeLoader.length;
			_loaderView.changePercent(percent);
		}
	}

}