package maryfisher.framework.view.core {
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.core.managers.Stage3DProxy;
	import away3d.debug.AwayStats;
	import away3d.loaders.parsers.Parsers;
	import flash.display.Stage;
	import maryfisher.framework.command.view.Model3DCommand;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.core.IViewController;
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.view.ICameraController;
	import maryfisher.framework.view.ICameraObject;
	import maryfisher.framework.view.IViewComponent;
	import maryfisher.framework.view.BaseView3D;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseAway3DController implements IViewController{
		
		private var _stage:Stage;
		
		protected var _view3d:BaseView3D;
		protected var _scene:Scene3D;
		
		private var _cameraController:ICameraController;
		
		private var _paused:Boolean = true;
		private var _awayStats:AwayStats;
		private var _id:String;
		protected var _controller:ViewController;
		//private var _defaultViewPaused:Boolean = false;
		
		public function BaseAway3DController(id:String) {
			_id = id;
			Parsers.enableAllBundled();
		}
		
		public function setUp(stage:Stage, controller:ViewController):void {
			_controller = controller;
			_stage = stage;
		}
		
		public function addView(view:IViewComponent):void {
			_scene.addChild(view as ObjectContainer3D);
			registerView(view);
		}
		
		public function removeView(view:IViewComponent):void {
			_scene.removeChild(view as ObjectContainer3D);
			unRegisterView(view);
		}
		
		public function pauseView():void {
			_paused = true;
		}
		
		public function continueView():void {
			_paused = false;
		}
		
		public function registerView(view:IViewComponent):void {
			if (view is ICameraObject) {
				_cameraController && _cameraController.registerCameraObject(view as ICameraObject);
			}
		}
		
		public function unRegisterView(view:IViewComponent):void {
			if (view is ICameraObject) {
				_cameraController && _cameraController.unregisterCameraObject(view as ICameraObject);
			}
		}
		
		public function registerCommand(viewCommand:ViewCommand):void {
			
			switch (viewCommand.viewCommandType) {
				case Model3DCommand.REGISTER_VIEW3D:
					_view3d = (viewCommand as Model3DCommand).view3D;
					_scene = _view3d.scene;
					_cameraController = _view3d.cameraController;
					_cameraController && _cameraController.start(_stage);
					_stage.addChildAt(_view3d, 0);
					_paused = false
					
					if(!_awayStats){
						_awayStats = new AwayStats(_view3d);
						_stage.addChild(_awayStats);
					}
					//_stage3DProxy.addEventListener(Event.ENTER_FRAME, onEnterFrame);
				break;
				//case Model3DCommand.REGISTER_SCENE:
					//_defaultViewPaused = true;
					//_view.scene = (viewCommand as Model3DCommand).scene;
					//_view.camera = (viewCommand as Model3DCommand).camera;
				//break;
				case Model3DCommand.UNREGISTER_VIEW3D:
					_paused = true;
					_view3d.dispose();
					_view3d = null;
					//_stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					//_view.scene = _scene;
					//_view.camera = _camera;
					//_defaultViewPaused = false;
				break;
				default:
			}
		}
		
		public function render():void {
			if (_paused) {
				return;
			}
			_view3d.render();
		}
		
		public function get controllerId():String {
			return _id;
		}
	}

}