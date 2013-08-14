package maryfisher.framework.view.core {
	import away3d.core.managers.Stage3DProxy;
	import starling.display.Sprite;
	import maryfisher.framework.core.ViewController;
	import flash.display.Stage;
	import starling.core.Starling;
	import starling.events.Event;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class StarlingProxyController extends BaseStarlingController implements IProxyController {
		private var _stage3DProxy:Stage3DProxy;
		
		public function StarlingProxyController(id:String) {
			super(id);
		}
		
		override public function render():void {
			//trace("starling");
			_starling.nextFrame();
			
			// Present the Context3D object to Stage3D
			_stage3DProxy.present();
			//trace("present");
		}
		
		override protected function init():void {
			
		}
		
		public function setUpProxy(stage3DProxy:Stage3DProxy):void {
			_stage3DProxy = stage3DProxy;
			
			_starling = new Starling(Sprite, _stage, _stage3DProxy.viewPort, _stage3DProxy.stage3D);
			onContextCreated(null);
		}
	}

}