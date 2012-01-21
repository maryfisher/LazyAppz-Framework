package maryfisher.framework.view.controller {
	import flash.display.DisplayObject;
	import maryfisher.framework.core.ViewController;
	import flash.display.Stage;
	import maryfisher.framework.view.IViewComponent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class DisplayController implements IViewController {
		private var _stage:Stage;
		
		public function DisplayController() {
			
		}
		
		/* INTERFACE maryfisher.framework.view.controller.IViewController */
		
		public function addView(view:IViewComponent):void {
			if(view.componentType == ViewController.SPRITE){
				_stage.addChild(view as flash.display.DisplayObject);
				return;
			}
		}
		
		public function removeView(view:IViewComponent):void {
			if(view.componentType == ViewController.SPRITE){
				_stage.removeChild(view as DisplayObject);
				return;
			}
		}
		
		public function setUp(stage:Stage, controller:ViewController):void {
			_stage = stage;
			
		}
		
		public function pauseView():void {
			
		}
		
		public function continueView():void {
			
		}
		
		public function get controllerId():String {
			return ViewController.SPRITE;
		}
		
	}

}