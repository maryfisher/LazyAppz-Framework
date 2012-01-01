package maryfisher.framework.core {
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.loaders.parsers.Parsers;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.view.IViewComponent;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ViewController {
		
		public static const SPRITE:String = "sprite";
		public static const STARLING:String = "starling";
		public static const MODEL3D:String = "model3d";
		
		static private var _instance:ViewController;
		
		
		/**
		 * Sprite
		 */
		private var _stage:Stage;
		
		/**
		 * Starling
		 */
		
		private var _tickedObjects:Vector.<IViewComponent>;
		private var _starling:Starling;
		private var _view:View3D;
		private var _camera:Camera3D;
		private var _scene:Scene3D;
		
		public function ViewController() {
			
		}
		
		static public function getInstance():ViewController {
			if (!_instance) {
				_instance = new ViewController();
			}
			return _instance;
		}
		
		static public function init(stage:Stage, comp:String, rootClass:Class = null):void {
			getInstance()._stage = stage;
			
			_instance.prepareStage(comp, rootClass);
		}
		
		private function prepareStage(comp:String, rootClass:Class):void {
			if (comp == SPRITE) {
				return;
			}
			
			if (comp == MODEL3D) {
				_scene = new Scene3D();
			
				//setup camera for optimal shadow rendering
				_camera = new Camera3D();
				_camera.lens.far = 2100;
				
				_view = new View3D();
				_view.scene = _scene;
				_view.camera = _camera;
				
				Parsers.enableAllBundled();
				
				_stage.addChild(_view);
				return;
			}
			
			if (comp == STARLING) {
				_starling = new Starling(rootClass, _stage);
				_starling.start();
			}
		}
		
		static public function registerCommand(viewCommand:ViewCommand):void {
			_instance.executeCommand(viewCommand);
			
		}
		
		private function executeCommand(viewCommand:ViewCommand):void {
			
			switch (viewCommand.viewCommandType) {
				case ViewCommand.ADD_VIEW:
					addView(viewCommand.view);
					break;
				case ViewCommand.REMOVE_VIEW:
					removeView(viewCommand.view);
					break;
				case ViewCommand.TOGGLE_FULL_SCREEN:
					toggleFullScreen();
					break;
				case ViewCommand.PAUSE:
					_starling && _starling.stop();
					break;
				case ViewCommand.CONTINUE:
					_starling && _starling.start();
					break;
				default:
			}
		}
		
		private function addView(view:IViewComponent):void {
			if(view.componentType == SPRITE){
				_stage.addChild(view as flash.display.DisplayObject);
				return;
			}
			
			if (view.componentType == MODEL3D) {
				_scene.addChild(view as ObjectContainer3D);
				return;
			}
			
			if (view.componentType == STARLING) {
				_starling.stage.addChild(view as starling.display.DisplayObject);
			}
		}
		
		private function removeView(view:IViewComponent):void {
			if(view.componentType == SPRITE){
				_stage.removeChild(view as flash.display.DisplayObject);
				return;
			}
			
			if (view.componentType == STARLING) {
				_starling.stage.removeChild(view as starling.display.DisplayObject);
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