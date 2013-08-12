package maryfisher.framework.view.core {
	import away3d.core.managers.Stage3DProxy;
	import flash.display.Sprite;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.core.ViewController;
	import flash.display.Stage;
	import maryfisher.framework.core.IViewController;
	import maryfisher.framework.view.IViewComponent;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseStarlingController implements IViewController {
		
		private var _id:String;
		private var _paused:Boolean;
		private var _stage:Stage;
		private var _controller:ViewController;
		
		public function BaseStarlingController(id:String) {
			_id = id;
		}
		
		/* INTERFACE maryfisher.framework.core.IViewController */
		
		public function get controllerId():String {
			return _id;
		}
		
		public function addView(view:IViewComponent):void {
			_starling.stage.addChild(view as DisplayObject);
		}
		
		public function removeView(view:IViewComponent):void {
			_starling.stage.removeChild(view as DisplayObject);
		}
		
		public function setUp(stage:Stage, controller:ViewController):void {
			_controller = controller;
			_stage = stage;
			
			init();
		}
		
		protected function init():void {
			_starling = new Starling(Sprite, _stage);
		}
		
		public function pauseView():void {
			_paused = true;
		}
		
		public function continueView():void {
			_paused = false;
		}
		
		public function registerView(view:IViewComponent):void {
			
		}
		
		public function unRegisterView(view:IViewComponent):void {
			
		}
		
		public function registerCommand(viewCommand:ViewCommand):void {
			
		}
		
		public function render():void {
			
		}
		
	}

}