package view.camera {
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractCameraBehavior {
		
		protected var _stage:Stage;
		protected var _cameraController:BaseCameraController;
		
		public function AbstractCameraBehavior(cameraController:BaseCameraController) {
			_cameraController = cameraController;
			
		}
		
		public function start(stage:Stage):void {
			_stage = stage;
			
		}
		
		public function stop():void {
			
		}
		
		public function onEnterFrame(e:Event):void {
			
		}
	}

}