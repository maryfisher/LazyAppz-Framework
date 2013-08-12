package maryfisher.framework.view.core {
	import maryfisher.framework.core.ViewController;
	import flash.display.Stage;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Away3DProxyController extends BaseAway3DController {
		private var _proxyController:Vector.<IProxyController>;
		
		public function Away3DProxyController(controller:Vector.<IProxyController>, id:String) {
			super(id);
			_proxyController = controller;
			
		}
		
		override public function setUp(stage:Stage, controller:ViewController):void {
			super.setUp(stage, controller);
			
			// Define a new Stage3DSpiritger for the Stage3D objects
			var stage3DSpiritger:Stage3DSpiritger = Stage3DSpiritger.getInstance(stage);
			
			// Create a new Stage3D proxy to contain the separate views
			_stage3DProxy = stage3DSpiritger.getFreeStage3DProxy();
			_stage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_CREATED, onContextCreated);
		}
		
		private function onContextCreated(e:Stage3DEvent):void {
			
			for each(var viewcontroller:IProxyController in _proxyController) {
				viewcontroller.setUpProxy(_stage3DProxy);
			}
			
			_controller.start();
			
		}
		
		public function setUpProxy(stage3DProxy:Stage3DProxy):void {
			_stage3DProxy = stage3DProxy;
			
		}
		
		override public function render():void {
			
			_stage3DProxy.clear();
			super.render();
		}
		
	}

}