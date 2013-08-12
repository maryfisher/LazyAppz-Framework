package maryfisher.framework.view.core {
	import flash.display.Sprite;
	import maryfisher.framework.core.ViewController;
	import flash.display.Stage;
	import starling.core.Starling;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class StarlingProxyController extends BaseStarlingController {
		
		public function StarlingProxyController(id:String) {
			super(id);
		}
		
		override public function render():void {
			super.render();
			
			// Present the Context3D object to Stage3D
			_stage3DProxy.present();
		}
		
		override protected function init():void {
			
		}
		
		public function setUpProxy(stage3DProxy:Stage3DProxy):void {
			_stage3DProxy = stage3DProxy;
			
			_starling = new Starling(Sprite, _stage, _stage3DProxy.viewPort, _stage3DProxy.stage3D);
		}
	}

}