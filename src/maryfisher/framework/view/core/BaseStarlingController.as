package maryfisher.framework.view.core {
	import away3d.core.managers.Stage3DProxy;
	import flash.display.Sprite;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.core.ViewController;
	import flash.display.Stage;
	import maryfisher.framework.core.IViewController;
	import maryfisher.framework.view.IStarlingView;
	import maryfisher.framework.view.IViewComponent;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseStarlingController implements IViewController {
		
		private var _id:String;
		protected var _paused:Boolean;
		protected var _stage:Stage;
		private var _controller:ViewController;
		protected var _starling:Starling;
		private var _hasContext:Boolean;
		
		public function BaseStarlingController(id:String) {
			_id = id;
		}
		
		/* INTERFACE maryfisher.framework.core.IViewController */
		
		public function get controllerId():String {
			return _id;
		}
		
		public function addView(view:IViewComponent):void {
			_starling.stage.addChild(view as DisplayObject);
			if (_hasContext) (view as IStarlingView).init();
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
			_starling = new Starling(starling.display.Sprite, _stage);
			_starling.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
		}
		
		protected function onContextCreated(e:Event):void {
			for (var i:int = 0; i < _starling.stage.numChildren; i++) {
				var sv:IStarlingView = (_starling.stage.getChildAt(i) as IStarlingView);
				if (!sv) continue;
				sv.init();
			}
			_hasContext = true;
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
			_starling.render();
		}
		
	}

}