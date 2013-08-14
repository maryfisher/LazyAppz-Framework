package maryfisher.framework.view {
	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import maryfisher.framework.view.ICameraController;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseView3D extends View3D{
		
		private var _cameraController:ICameraController;
		
		public function BaseView3D(x:int, y:int, width:int, height:int) {
			super(null, null);
			this.width = width;
			this.height = height;
			this.x = x;
			this.y = y;
			
		}
		
		public function get cameraController():ICameraController {
			return _cameraController;
		}
		
		public function set cameraController(value:ICameraController):void {
			_cameraController = value;
			_cameraController.assignBounds(x, x + width, y, y + width);
		}
		
		public function destroy():void {
			
		}
		
		public function addOnFinished(listener:Function):void {
			
		}
		
	}

}