package maryfisher.framework.core {
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.lights.DirectionalLight;
	import away3d.loaders.parsers.Parsers;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.view.controller.DisplayController;
	import maryfisher.framework.view.controller.IViewController;
	import maryfisher.framework.view.controller.Model3DController;
	import maryfisher.framework.view.controller.StarlingController;
	import maryfisher.framework.view.IResizableObject;
	import maryfisher.framework.view.ITickedObject;
	import maryfisher.framework.view.IViewComponent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ViewController {
		
		public static const SPRITE:String = "sprite";
		public static const STARLING:String = "starling";
		public static const MODEL3D:String = "model3d";
		
		static private var _instance:ViewController;
		
		private var _stage:Stage;
		private var _viewController:Dictionary; /* of IViewController */
		
		private var _tickedObjects:Vector.<ITickedObject>;
		private var _resiableObjects:Vector.<IResizableObject>;
		
		public function ViewController() {
			
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
			
			for each(var viewcontroller:IViewController in comps) {
				//var viewcontroller:IViewController;
				//if (comp == STARLING) {
					//viewcontroller = new StarlingController();
				//}else if (comp == MODEL3D) {
					//viewcontroller = new Model3DController();
				//}else if (comp == SPRITE) {
					//viewcontroller = new DisplayController();
				//}
				
				_viewController[viewcontroller.controllerId] = viewcontroller;
				viewcontroller && viewcontroller.setUp(_stage, this);
			}
			
			_stage.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			
			
		}
		
		private function handleEnterFrame(e:Event):void {
			
		}
		
		static public function registerCommand(viewCommand:ViewCommand):void {
			_instance.executeCommand(viewCommand);
			
		}
		
		private function executeCommand(viewCommand:ViewCommand):void {
			var viewcontroller:IViewController = (_viewController[viewCommand.view.componentType] as IViewController);
			
			//if (!viewcontroller) {
				checkForCallbacks(viewCommand);
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
				default:
			}
		}
		
		private function checkForCallbacks(viewCommand:ViewCommand):void {
			var doAdd:Boolean = (viewCommand.viewCommandType == ViewCommand.ADD_VIEW)
			if (viewCommand.view is IResizableObject) {
				if (doAdd) {
					_resiableObjects.push(viewCommand.view as IResizableObject);
				}else {
					
				}
			}
			
			if (viewCommand.view is ITickedObject) {
				if (doAdd) {
					_tickedObjects.push(viewCommand.view as ITickedObject);
				}else {
					
				}
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