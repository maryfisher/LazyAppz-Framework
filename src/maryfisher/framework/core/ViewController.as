package maryfisher.framework.core {
	
    import flash.display.Stage;
    import flash.display.StageDisplayState;
    import flash.events.Event;
    import flash.ui.Mouse;
    import flash.utils.Dictionary;
    import flash.utils.getTimer;
    import maryfisher.framework.command.view.StageCommand;
    import maryfisher.framework.command.view.ViewCommand;
    import maryfisher.framework.view.IResizableObject;
    import maryfisher.framework.view.ITickedObject;
    import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ViewController {
		
		static public const Z_NORMAL:int = 0;
		static public const Z_BOTTOM:int = -1;
		
		static private var _instance:ViewController;
		static private var _isFinished:Boolean;
		static private var _onFinished:Signal = new Signal();
		
		private var _stage:Stage;
		private var _viewController:Dictionary; /* of IViewController */
		
		private var _tickedObjects:Vector.<ITickedObject>;
		private var _resizableObjects:Vector.<IResizableObject>;
		/** TODO
		 * addable behavior instead
		 */
		//private var _mouseObjects:Vector.<IMouseObject>;
		
		private var _oldTime:int;
		private var _viewList:Vector.<IViewController>;
		
		
		public function ViewController() {
			_tickedObjects = new Vector.<ITickedObject>;
			_resizableObjects = new Vector.<IResizableObject>();
			//_mouseObjects = new Vector.<IMouseObject>();
		}
		
		static public function getInstance():ViewController {
			if (!_instance) {
				_instance = new ViewController();
			}
			return _instance;
		}
		
		static public function init(stage:Stage, comps:Array):void {
			
			getInstance().prepareStage(stage, comps);
		}
		
		private function prepareStage(stage:Stage, comps:Array):void {
			
			_stage = stage;
			_viewController = new Dictionary();
			_viewList = Vector.<IViewController>(comps);
			
			for each(var viewcontroller:IViewController in comps) {
				_viewController[viewcontroller.controllerId] = viewcontroller;
				viewcontroller.setUp(_stage, this);
			}
			
		}
		
		//private function onMouseWheel(e:MouseEvent):void {
			//var l:int = _mouseObjects.length;
			//for (var i:int = 0; i < l; i++) {
				//_mouseObjects[i].onMouseEvent(e);
			//}
		//}
		
		private function handleEnterFrame(e:Event):void {
			
			var interval:int = getTimer() - _oldTime;
			_oldTime += interval;
			for each(var obj:ITickedObject in _tickedObjects) {
				obj.nextTick(interval);	
			}
			
			var l:int = _viewList.length;
			for (var i:int = 0; i < l; i++) {
				_viewList[i].render();
			}
		}
		
		static public function registerCommand(viewCommand:ViewCommand):void {
			_instance.executeCommand(viewCommand);
			
		}
		
		static public function registerStageCommand(stageCommand:StageCommand):void {
			_instance.executeStageCommand(stageCommand);
		}
		
		static public function start():void {
			_instance.startListener();
		}
		
		static public function onFinished(onFinished:Function):void {
			if (_isFinished) onFinished();
			else _onFinished.addOnce(onFinished);
		}
		
		private function startListener():void {
			_oldTime = getTimer();
			_stage.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			_onFinished.dispatch();
			_isFinished = true;
			/** TODO
			 * what to do with the mouse events?
			 */
		}
		
		private function executeStageCommand(stageCommand:StageCommand):void {
			switch (stageCommand.commandType) {
				case StageCommand.REGISTER_TICK:
					_tickedObjects.push(stageCommand.obj as ITickedObject);
				break;
				case StageCommand.UNREGISTER_TICK:
					_tickedObjects.splice(_tickedObjects.indexOf(stageCommand.obj), 1);
				break;
				case StageCommand.REGISTER_RESIZE:
					_resizableObjects.push(stageCommand.obj as IResizableObject);
				break;
				case StageCommand.UNREGISTER_RESIZE:
					_resizableObjects.splice(_resizableObjects.indexOf(stageCommand.obj), 1);
				break;
				case StageCommand.REGISTER_MOUSE:
					//_mouseObjects.push(stageCommand.obj as IMouseObject);
				break;
				case StageCommand.UNREGISTER_MOUSE:
					//_mouseObjects.splice(_mouseObjects.indexOf(stageCommand.obj), 1);
				break;
			}
		}
		
		static public function get stageHeight():int {
			if (_instance._stage.displayState == StageDisplayState.FULL_SCREEN) {
				return _instance._stage.fullScreenHeight;
			}
			return _instance._stage.stageHeight;
		}
		
		static public function get stageWidth():int {
			if (_instance._stage.displayState == StageDisplayState.FULL_SCREEN) {
				return _instance._stage.fullScreenWidth;
			}
			return _instance._stage.stageWidth;
		}
		
		static public function get fullScreenHeight():uint {
			return _instance._stage.fullScreenHeight;
		}
		
		static public function get fullScreenWidth():uint {
			return _instance._stage.fullScreenWidth;
		}
		
		private function executeCommand(viewCommand:ViewCommand):void {
			
			var viewcontroller:IViewController = (_viewController[viewCommand.viewType] as IViewController);
			
			if (!viewcontroller) {
				switch (viewCommand.viewCommandType) {
					case ViewCommand.TOGGLE_FULL_SCREEN:
						toggleFullScreen();
					break;
					default:
						throw new Error("What's up with that view id? - " + viewCommand.viewType);
				}
				return;
			}
			
			switch (viewCommand.viewCommandType) {
				case ViewCommand.ADD_VIEW:
					viewcontroller.addView(viewCommand.view);
					break;
				case ViewCommand.REMOVE_VIEW:
					viewcontroller.removeView(viewCommand.view);
					break;
				case ViewCommand.PAUSE:
					viewcontroller.pauseView();
					break;
				case ViewCommand.CONTINUE:
					viewcontroller.continueView();
					break;
				case ViewCommand.REGISTER_VIEW:
					viewcontroller.registerView(viewCommand.view);
					//checkForCallbacks(viewCommand.view);
					break;
				case ViewCommand.UNREGISTER_VIEW:
					viewcontroller.unRegisterView(viewCommand.view);
					//removeCallbacks(viewCommand.view);
					break;
				case ViewCommand.SWITCH_MOUSE:
					Mouse.cursor = viewCommand.viewType
					break;
				default:
					viewcontroller.registerCommand(viewCommand);
					break;
			}
		}
		
		//private function checkForCallbacks(view:IViewComponent):void {
			//if (view is IResizableObject) {
				//_resizableObjects.push(view as IResizableObject);
			//}
			//
			//if (view is ITickedObject) {
				//_tickedObjects.push(view as ITickedObject);
			//}
		//}
		//
		//private function removeCallbacks(view:IViewComponent):void {
			//if (view is IResizableObject) {
				//_resizableObjects.push(_resizableObjects.indexOf(view as IResizableObject));
			//}
			//
			//if (view is ITickedObject) {
				//_tickedObjects.splice(_tickedObjects.indexOf(view as ITickedObject), 1);
			//}
		//}
		
		private function toggleFullScreen():void {
			switch (_stage.displayState) {
				case StageDisplayState.FULL_SCREEN:
					/* If already in full screen mode, switch to normal mode. */
					_stage.displayState = StageDisplayState.NORMAL;
					break;
				default:
					/* If not in full screen mode, switch to full screen mode. */
					//_instance._stage.fullScreenSourceRect = new Rectangle (0,20,640,480); 
					_stage.displayState = StageDisplayState.FULL_SCREEN;
					break;
			}
			
			for each (var item:IResizableObject in _resizableObjects) {
				item.resize();
			}
		}
	}
}