package maryfisher.framework.view.controller {
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.loaders.parsers.Parsers;
	import flash.display.Stage;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Model3DController implements IViewController{
		
		private var _stage:Stage;
		
		private var _view:View3D;
		private var _camera:Camera3D;
		private var _scene:Scene3D;
		
		public function Model3DController() {
			
		}
		
		public function setUp():void {
			_scene = new Scene3D();
			
			//setup camera for optimal shadow rendering
			_camera = new Camera3D();
			_camera.lens.far = 2100;
			
			_view = new View3D();
			_view.scene = _scene;
			_view.camera = _camera;
			
			Parsers.enableAllBundled();
			
			_stage.addChild(_view);
		}
	}

}