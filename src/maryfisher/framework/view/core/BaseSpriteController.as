package maryfisher.framework.view.core {
	//import away3d.core.managers.Stage3DProxy;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.core.ViewController;
	import flash.display.Stage;
	import maryfisher.framework.core.IViewController;
	import maryfisher.framework.view.IViewComponent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSpriteController implements IViewController {
		private var _id:String;
		
		protected var _stage:Stage;
		protected var _scene:Sprite;
		
		public function BaseSpriteController(id:String) {
			_id = id;
			
		}
		
		/* INTERFACE maryfisher.framework.core.IViewController */
		
		public function addView(view:IViewComponent):void {
			_scene.addChild(view as DisplayObject);
		}
		
		public function removeView(view:IViewComponent):void {
			_scene.removeChild(view as DisplayObject);
		}
		
		public function setUp(stage:Stage, controller:ViewController):void {
			_stage = stage;
			_scene = new Sprite();
			_stage.addChild(_scene);
		}
		
		public function pauseView():void {
			
		}
		
		public function continueView():void {
			
		}
		
		public function registerView(view:IViewComponent):void {
			
		}
		
		public function unRegisterView(view:IViewComponent):void {
			
		}
		
		public function registerCommand(viewCommand:ViewCommand):void {
			
		}
		
		//public function setUpProxy(stage3DProxy:Stage3DProxy):void {
			//
		//}
		
		public function render():void {
			
		}
		
		public function get controllerId():String {
			return _id;
		}
		
	}

}