package maryfisher.framework.view.controller {
	import maryfisher.framework.core.ViewController;
	import flash.display.Stage;
	import maryfisher.framework.view.IViewComponent;
	import starling.core.Starling;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class StarlingController implements IViewController {
		
		private var _starling:Starling;
		private var _stage:Stage;
		private var _controller:ViewController;
		
		public function StarlingController() {
			
		}
		
		/* INTERFACE maryfisher.framework.view.controller.IViewController */
		
		public function addView(view:IViewComponent):void {
			if (view.componentType == ViewController.STARLING) {
				_starling.stage.addChild(view as starling.display.DisplayObject);
			}
		}
		
		public function removeView(view:IViewComponent):void {
			if (view.componentType == ViewController.STARLING) {
				_starling.stage.removeChild(view as starling.display.DisplayObject);
			}
		}
		
		public function setUp(stage:Stage, controller:ViewController):void {
			_controller = controller;
			_stage = stage;
			
			_starling = new Starling(_controller.rootClass, _stage);
			_starling.start();
		}
		
		public function pauseView():void {
			_starling && _starling.stop();
		}
		
		public function continueView():void {
			_starling && _starling.start();
		}
		
		public function get controllerId():String {
			return ViewController.STARLING;
		}
		
	}

}