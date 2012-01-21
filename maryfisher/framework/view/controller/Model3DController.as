package maryfisher.framework.view.controller {
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.library.AssetLibrary;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.loaders.parsers.MD5AnimParser;
	import away3d.loaders.parsers.MD5MeshParser;
	import away3d.loaders.parsers.Parsers;
	import away3d.materials.ColorMaterial;
	import away3d.materials.MaterialBase;
	import away3d.primitives.Plane;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.view.IViewComponent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Model3DController implements IViewController{
		
		private var _stage:Stage;
		
		private var _view:View3D;
		//private var _camera:Camera3D;
		private var _scene:Scene3D;
		
		//private var _cameraController:HoverController;
		//private var light:PointLight;
		//private var direction:Vector3D;
		//navigation variables
		//private var move:Boolean = false;
		//private var lastPanAngle:Number;
		//private var lastTiltAngle:Number;
		//private var lastMouseX:Number;
		//private var lastMouseY:Number;
		
		public function Model3DController() {
			
			//AssetLibrary.enableParsers(Parsers.ALL_BUNDLED);
			//AssetLibrary.enableParser(MD5AnimParser);
			//AssetLibrary.enableParser(MD5MeshParser);
		}
		
		public function init(view:View3D):void {
			_view = view;
			_scene = _view.scene;
			//_view.scene = _scene;
		}
		
		public function setUp(stage:Stage, controller:ViewController):void {
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			
			_stage = stage;
			
			//_scene = new Scene3D();
			
			//setup camera for optimal shadow rendering
			//_camera = new Camera3D();
			//_camera.lens.far = 2100;
			
			//_cameraController = new HoverController(_camera, null, 45, 20, 100, 10);
			
			//_view = new View3D();
			//_view.scene = _scene;
			//_view.camera = _camera;
			
			
			_stage.addChild(_view);
		//}
		
		/**
		 * Initialise the listeners
		 */
		//private function initListeners():void
		//{
			//_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			//_stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			//_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			//_stage.addEventListener(Event.RESIZE, onResize);
			//onResize();
		}
		
		//private function onEnterFrame(event:Event):void
		//{
			//if (move) {
				//_cameraController.panAngle = 0.3 * (_stage.mouseX - lastMouseX) + lastPanAngle;
				//_cameraController.tiltAngle = 0.3 * (_stage.mouseY - lastMouseY) + lastTiltAngle;
			//}
			//
			//_view.render();
		//}
		
		/**
		 * Mouse down listener for navigation
		 */
		//private function onMouseDown(event:MouseEvent):void
		//{
			//lastPanAngle = _cameraController.panAngle;
			//lastTiltAngle = _cameraController.tiltAngle;
			//lastMouseX = _stage.mouseX;
			//lastMouseY = _stage.mouseY;
			//move = true;
			//_stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		//}
		
		/**
		 * Mouse up listener for navigation
		 */
		//private function onMouseUp(event:MouseEvent):void
		//{
			//move = false;
			//_stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		//}
		
		/**
		 * Mouse stage leave listener for navigation
		 */
		//private function onStageMouseLeave(event:Event):void
		//{
			//move = false;
			//_stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		//}
		
		/* INTERFACE maryfisher.framework.view.controller.IViewController */
		
		public function addView(view:IViewComponent):void {
			if (view.componentType == ViewController.MODEL3D) {
				_scene.addChild(view as ObjectContainer3D);
				/* TODO
				 * view/camera übergeben?
				 */
				return;
			}
		}
		
		public function removeView(view:IViewComponent):void {
			
		}
		
		public function pauseView():void {
			
		}
		
		public function continueView():void {
			
		}
		
		public function get controllerId():String {
			return ViewController.MODEL3D;
		}
	}

}