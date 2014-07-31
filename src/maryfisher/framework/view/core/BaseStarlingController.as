package maryfisher.framework.view.core {
	//import flash.display.Sprite;
	import flash.display.Stage;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.core.IViewController;
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.view.IStarlingView;
	import maryfisher.framework.view.IViewComponent;
	import org.osflash.signals.Signal;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseStarlingController implements IViewController, IStarlingController {
		private var _onFinished:Signal;
		
		private var _id:String;
		protected var _paused:Boolean;
		protected var _stage:Stage;
		private var _controller:ViewController;
		protected var _starling:Starling;
		protected var _hasContext:Boolean;
		protected var _container:starling.display.Sprite;
		
		public function BaseStarlingController(id:String) {
			_id = id;
			_onFinished = new Signal(Starling);
			_container = new Sprite();
		}
		
		/* INTERFACE maryfisher.framework.core.IViewController */
		
		public function get controllerId():String {
			return _id;
		}
		
		public function get onFinished():Signal {
			return _onFinished;
		}
		
		public function addView(view:IViewComponent):void {
			_container.addChild(view as DisplayObject);
			if (_hasContext) (view as IStarlingView).init();
		}
		
		public function removeView(view:IViewComponent):void {
			_container.removeChild(view as DisplayObject);
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
			_starling.stage.addChild(_container);
			_onFinished.dispatch(_starling);
			initComps();
			
			
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
		
		protected function initComps():void {
			for (var i:int = 0; i < _container.numChildren; i++) {
				var sv:IStarlingView = (_container.getChildAt(i) as IStarlingView);
				if (!sv) continue;
				sv.init();
			}
			_hasContext = true;
		}
		
	}

}