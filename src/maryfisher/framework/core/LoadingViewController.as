package maryfisher.framework.core {
	import away3d.core.managers.Stage3DProxy;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.utils.Dictionary;
	import maryfisher.framework.command.view.AbstractProgress;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.view.ILoaderView;
	import maryfisher.framework.view.IViewComponent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LoadingViewController implements IViewController {
		
		static public const LOADING_VIEW:String = "loadingView";
		static public const ADD_SEQUENCE:String = "addSequence";
		static public const SHOW_LOADING:String = "showLoading";
		static public const HIDE_LOADING:String = "hideLoading";
		
		static public const START_GLOBAL_SEQUENCE:String = "startGlobalSequence";
		
		private var _progressCommands:Vector.<AbstractProgress>;
		
		private var _activeProgress:AbstractProgress;
		//private var _globalSequenceProgress:GlobalSequenceProgress;
		
		private var _loadingView:ILoaderView;
		private var _loadingViews:Dictionary;
		private var _container:Sprite = new Sprite();
		private var _stage:Stage;
		private var _keepView:Boolean = false;
		
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
			if (!(viewCommand is AbstractProgress)) {
				//if (viewCommand.viewCommandType == START_GLOBAL_SEQUENCE) {
					//_globalSequenceProgress = new SequenceProgress()
				//}
				if (viewCommand.viewCommandType == SHOW_LOADING) {
					_keepView = true;
					_loadingView && _loadingView.show();
				}else if (viewCommand.viewCommandType == HIDE_LOADING) {
					_keepView = false;
					if(_progressCommands.length == 0) _loadingView && _loadingView.hide();
				}
				return;
			}
			
			
			var abstractProgress:AbstractProgress = viewCommand as AbstractProgress;
			
			//if (abstractProgress is GlobalSequenceProgress) {
				//_globalSequenceProgress = abstractProgress as GlobalSequenceProgress;
				//abstractProgress.addFinishedListener(onProgress, onFinished);
				//return;
			//}
			
			//if (abstractProgress is SequenceProgress && _globalSequenceProgress) {
				//_globalSequenceProgress.addSequence(abstractProgress as SequenceProgress);
				//return;
			//}
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
		
		/* INTERFACE maryfisher.framework.core.IViewController */
		
		public function setUpProxy(stage3DProxy:Stage3DProxy):void {
			
		}
		
		public function render():void {
			
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
				//if(_globalSequenceProgress.steps){
				//if(!_globalSequenceProgress){
				if (!_keepView){
					_loadingView && _loadingView.hide();
				}
				
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
				//for (var i:int = 0; i < _progressCommands.length; i++ ) {
					//_loadingView.addDescription(_progressCommands[i].getDescription());
				//}
			//}
		}
		
	}

}