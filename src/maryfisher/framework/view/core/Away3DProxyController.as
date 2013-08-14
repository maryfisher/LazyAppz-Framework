package maryfisher.framework.view.core {
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.events.Stage3DEvent;
	import maryfisher.framework.command.view.Model3DCommand;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.core.ViewController;
	import flash.display.Stage;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Away3DProxyController extends BaseAway3DController implements IProxyController {
		private var _proxyController:Vector.<IProxyController>;
		private var _stage3DProxy:Stage3DProxy;
		
		public function Away3DProxyController(controller:Vector.<IProxyController>, id:String) {
			super(id);
			_proxyController = controller;
			
		}
		
		override public function setUp(stage:Stage, controller:ViewController):void {
			super.setUp(stage, controller);
			
			// Define a new Stage3DSpiritger for the Stage3D objects
			var stage3DManager:Stage3DManager = Stage3DManager.getInstance(stage);
			
			// Create a new Stage3D proxy to contain the separate views
			_stage3DProxy = stage3DManager.getFreeStage3DProxy();
			_stage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_CREATED, onContextCreated);
		}
		
		override public function registerCommand(viewCommand:ViewCommand):void {
			
			switch (viewCommand.viewCommandType) {
				case Model3DCommand.REGISTER_VIEW3D:
					_view3d = (viewCommand as Model3DCommand).view3D;
					_view3d.stage3DProxy = _stage3DProxy;
					_view3d.shareContext = true;
					break;
			}
			super.registerCommand(viewCommand);
		}
		
		private function onContextCreated(e:Stage3DEvent):void {
			
			for each(var viewcontroller:IProxyController in _proxyController) {
				viewcontroller.setUpProxy(_stage3DProxy);
			}
			
			ViewController.start();
			
		}
		
		public function setUpProxy(stage3DProxy:Stage3DProxy):void {
			_stage3DProxy = stage3DProxy;
			
		}
		
		override public function render():void {
			
			//trace("clear");
			_stage3DProxy.clear();
			super.render();
			//trace("away3d render");
		}
		
	}

}