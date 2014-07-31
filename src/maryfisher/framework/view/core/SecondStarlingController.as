package maryfisher.framework.view.core {
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.core.ViewController;
	import flash.display.Stage;
	import maryfisher.framework.core.IViewController;
	import maryfisher.framework.view.IStarlingView;
	import maryfisher.framework.view.IViewComponent;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SecondStarlingController extends BaseStarlingController {
		
		private var _baseController:IStarlingController;
		
		public function SecondStarlingController(controllerId:String, baseController:IStarlingController) {
			super(controllerId);
			_baseController = baseController;
			_baseController.onFinished.addOnce(onContectCreated);
		}
		
		private function onContectCreated(starling:Starling):void {
			_starling = starling;
			_starling.stage.addChild(_container);
			_hasContext = true;
			initComps();
		}
		
		override protected function init():void {
			
		}
		
		override public function render():void {
			
		}
		
	}

}