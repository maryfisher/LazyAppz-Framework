package maryfisher.framework.command.view {
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.entities.Entity;
	import maryfisher.view.model3d.BaseView3D;
	
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.view.IViewComponent;
	
	/**
	 *
	 * @author mary_fisher
	 */
	public class Model3DCommand extends ViewCommand {
		
		//static public const REGISTER_CAMERA:String = "registerCamera";
		//static public const UNREGISTER_CAMERA:String = "unregisterCamera";
		//static public const REGISTER_SCENE:String = "registerScene";
		static public const REGISTER_VIEW3D:String = "registerView3d";
		static public const UNREGISTER_VIEW3D:String = "unregisterView3d";
		
		private var _view3D:BaseView3D;
		
		public function Model3DCommand(viewCommandType:String, viewType:String = "", view3D:BaseView3D = null) {
			_view3D = view3D;
			super(null, viewCommandType, viewType);
			
		}
		
		public function get view3D():BaseView3D {
			return _view3D;
		}
		
	}

}