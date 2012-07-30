package maryfisher.framework.core {
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.events.Stage3DEvent;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.view.IResizableObject;
	import maryfisher.framework.view.ITickedObject;
	import maryfisher.framework.view.IViewComponent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ViewController {
		
		//public static const SPRITE:String = "sprite";
		//public static const STARLING:String = "starling";
		//public static const MODEL3D:String = "model3d";
		
		static private var _instance:ViewController;
		
		private var _stage:Stage;
		private var _viewController:Dictionary; /* of IViewController */
		
		private var _tickedObjects:Vector.<ITickedObject>;
		private var _resiableObjects:Vector.<IResizableObject>;
		
		private var _oldTime:int;
		private var _stage3DProxy:Stage3DProxy;
		private var _viewList:Vector.<IViewController>;
		
		
		public function ViewController() {
			_tickedObjects = new Vector.<ITickedObject>;
			_resiableObjects = new Vector.<IResizableObject>();
		}
		
		static public function getInstance():ViewController {
			if (!_instance) {
				_instance = new ViewController();
			}
			return _instance;
		}
		
		//static public function init(stage:Stage, comps:Array, rootClass:Class = null):void {
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
			_oldTime = getTimer();
			_stage.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			// Define a new Stage3DManager for the Stage3D objects
			//var stage3DManager:Stage3DManager = Stage3DManager.getInstance(stage);
			//
			// Create a new Stage3D proxy to contain the separate views
			//_stage3DProxy = stage3DManager.getFreeStage3DProxy();
			//_stage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_CREATED, onContextCreated);
			
		}
		
		private function onContextCreated(e:Stage3DEvent):void {
			
			for each(var viewcontroller:IViewController in _viewList) {
				viewcontroller.setUpProxy(_stage3DProxy);
			}
			
			_oldTime = getTimer();
			_stage.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}
		
		private function handleEnterFrame(e:Event):void {
			
			/** TODO
			 * 
			 */
			//_stage3DProxy.clear();
			
			
			var interval:int = getTimer() - _oldTime;
			_oldTime += interval;
			for each(var obj:ITickedObject in _tickedObjects) {
				obj.nextTick(interval);	
			}
			
			var l:int = _viewList.length;
			for (var i:int = 0; i < l; i++) {
				_viewList[i].render();
			}
			
			// Present the Context3D object to Stage3D
			//_stage3DProxy.present();
		}
		
		static public function registerCommand(viewCommand:ViewCommand):void {
			_instance.executeCommand(viewCommand);
			
		}
		
		static public function get stageHeight():Number {
			return _instance._stage.stageHeight;
		}
		
		static public function get stageWidth():Number {
			return _instance._stage.stageWidth;
		}
		
		private function executeCommand(viewCommand:ViewCommand):void {
			
			var viewcontroller:IViewController = (_viewController[viewCommand.viewType] as IViewController);
			
			//if (!viewcontroller) {
				//return;
			//}
			
			switch (viewCommand.viewCommandType) {
				case ViewCommand.ADD_VIEW:
					viewcontroller.addView(viewCommand.view);
					break;
				case ViewCommand.REMOVE_VIEW:
					viewcontroller.removeView(viewCommand.view);
					break;
				case ViewCommand.TOGGLE_FULL_SCREEN:
					toggleFullScreen();
					break;
				case ViewCommand.PAUSE:
					viewcontroller.pauseView();
					break;
				case ViewCommand.CONTINUE:
					viewcontroller.continueView();
					break;
				case ViewCommand.REGISTER_VIEW:
					viewcontroller.registerView(viewCommand.view);
					checkForCallbacks(viewCommand.view);
					break;
				case ViewCommand.UNREGISTER_VIEW:
					viewcontroller.unRegisterView(viewCommand.view);
					removeCallbacks(viewCommand.view);
					break;
				default:
					viewcontroller.registerCommand(viewCommand);
					break;
			}
		}
		
		private function checkForCallbacks(view:IViewComponent):void {
			if (view is IResizableObject) {
				_resiableObjects.push(view as IResizableObject);
			}
			
			if (view is ITickedObject) {
				_tickedObjects.push(view as ITickedObject);
			}
		}
		
		private function removeCallbacks(view:IViewComponent):void {
			if (view is IResizableObject) {
				//_resiableObjects.push(viewCommand.view as IResizableObject);
			}
			
			if (view is ITickedObject) {
				_tickedObjects.splice(_tickedObjects.indexOf(view as ITickedObject), 1);
			}
		}
		
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
		}
	}
}