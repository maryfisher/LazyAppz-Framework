package maryfisher.framework.core {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import maryfisher.framework.command.view.AbstractProgress;
	import maryfisher.framework.command.view.ViewCommand;
	import flash.display.Stage;
	import maryfisher.framework.view.ILoaderView;
	import maryfisher.framework.view.IViewComponent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LoadingViewController implements IViewController {
		
		static public const LOADING_VIEW:String = "loadingView";
		static public const ADD_SEQUENCE:String = "addSequence";
		
		private var _progressCommands:Vector.<AbstractProgress>;
		private var _activeProgress:AbstractProgress;
		
		private var _loadingView:ILoaderView;
		private var _loadingViews:Dictionary;
		private var _container:Sprite = new Sprite();
		private var _stage:Stage;
		
		public function LoadingViewController() {
			_progressCommands = new Vector.<AbstractProgress>();
		}
		
		/* INTERFACE maryfisher.framework.core.IViewController */
		
		public function get controllerId():String {
			return LOADING_VIEW;
		}
		
		public function addView(view:IViewComponent):void {
			if (_loadingView) {
				_container.removeChild(_loadingView as DisplayObject);
			}
			_loadingView = view as ILoaderView;
			_loadingView.hide();
			_container.addChild(_loadingView as DisplayObject);
		}
		
		public function removeView(view:IViewComponent):void {
			if (_loadingView) {
				_container.removeChild(_loadingView as DisplayObject);
				_loadingView = null;
			}
		}
		
		public function setUp(stage:Stage, controller:ViewController):void {
			_stage = stage;
			_stage.addChild(_container);
		}
		
		public function pauseView():void {
			
		}
		
		public function continueView():void {
			
		}
		
		public function registerView(view:IViewComponent):void {
			
		}
		
		public function unRegisterView(view:IViewComponent):void {
			
		}
		
		public function registerCommand(viewCommand:ViewCommand):void {
			
			var abstractProgress:AbstractProgress = viewCommand as AbstractProgress;
			//trace("register new command", abstractProgress)
			if (!_activeProgress) {
				//trace("and it's the new active");
				_loadingView && _loadingView.changePercent(0);
				_loadingView && _loadingView.show();
				_activeProgress = abstractProgress;
			}else {
				//trace("and it has to be processed in line");
				_progressCommands.push(abstractProgress);
			}
			
			abstractProgress.addFinishedListener(onProgress, onFinished);
		}
		
		private function onFinished(cmd:AbstractProgress):void {
			//trace("onFinished", cmd);
			if (cmd == _activeProgress) {
				_loadingView && _loadingView.changePercent(1);
				_activeProgress = null;
				//trace("onFinished, commands left:", _progressCommands.length);
				if (_progressCommands.length > 0) {
					_activeProgress = _progressCommands.shift();
					//trace("new active Loader", _activeProgress)
					onProgress(_activeProgress);
					return;
				}
				
				_loadingView && _loadingView.hide();
				
				return;
			}
			
			_progressCommands.splice(_progressCommands.indexOf(cmd), 1);
			if (_progressCommands.length == 0) {
				//trace("so we have no commands left but also no active Loader?", _activeProgress);
			}
				//_loadingView && _loadingView.hide();
			
			//}else {
				onProgress(cmd);
			//}
		}
		
		private function onProgress(cmd:AbstractProgress):void {
			if (!_loadingView) {
				return;
			}
			
			_loadingView.changePercent(_activeProgress.progress);
			//if (cmd != _activeProgress) {
				_loadingView.resetDescriptions();
				_loadingView.addDescription(_activeProgress.getDescription());
				for (var i:int = 0; i < _progressCommands.length; i++ ) {
					_loadingView.addDescription(_progressCommands[i].getDescription());
				}
			//}
		}
		
	}

}