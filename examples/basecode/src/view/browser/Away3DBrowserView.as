package view.browser {
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.materials.methods.OutlineMethod;
	import away3d.primitives.CubeGeometry;
	import config.ViewConstants;
	import maryfisher.framework.command.view.Model3DCommand;
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.view.BaseView3D;
	import maryfisher.framework.view.core.BaseContainer3DView;
	import maryfisher.framework.view.IViewComponent;
	import view.camera.BaseCameraController;
	import view.camera.HoverCameraBehavior;
	import view.interfaces.IGameView3D;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Away3DBrowserView extends BaseContainer3DView implements IGameView3D {
		
		private var _baseView3D:BaseView3D;
		
		public function Away3DBrowserView() {
			_baseView3D = new BaseView3D(200, 0, ViewController.stageWidth - 200, ViewController.stageHeight);
			_baseView3D.camera.lens.far = 20000;
			var baseCameraController:BaseCameraController = new BaseCameraController(_baseView3D.camera, null, 0, 30, 8000);
			_baseView3D.cameraController = baseCameraController;
			baseCameraController.addBehavior(new HoverCameraBehavior(baseCameraController));
			
			var cube:Mesh = new Mesh(new CubeGeometry(2000, 2000, 2000), new ColorMaterial());
			//(cube.material as ColorMaterial).addMethod(new OutlineMethod());
			addChild(cube);
		}
		
		override public function addView():void {
			new Model3DCommand(Model3DCommand.REGISTER_VIEW3D, ViewConstants.GAME_VIEW_3D, _baseView3D);
			super.addView();
		}
		
		override public function get componentType():String {
			return ViewConstants.GAME_VIEW_3D;
		}
	}

}