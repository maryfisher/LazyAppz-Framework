package config {
	import data.StartUpData;
	import flash.display.Stage;
	import maryfisher.framework.command.AbstractCommand;
	import maryfisher.framework.core.IViewController;
	import maryfisher.framework.core.KeyController;
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.view.core.Away3DProxyController;
	import maryfisher.framework.view.core.BaseAway3DController;
	import maryfisher.framework.view.core.BaseSpriteController;
	import maryfisher.framework.view.core.BaseStarlingController;
	import maryfisher.framework.view.core.IProxyController;
	import maryfisher.framework.view.core.StarlingProxyController;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ConfigureViewCommand {
		
		public function ConfigureViewCommand() {
			super();
		}
		
		public function execute(stage:Stage, startUpData:StartUpData):void {
			KeyController.init(stage);
			var awayController:IViewController;
			var spriteController:IViewController;
			
			if (startUpData.useStarling) {
				spriteController = new StarlingProxyController(ViewConstants.GAME_VIEW);
				awayController = new Away3DProxyController(Vector.<IProxyController>([spriteController]), ViewConstants.GAME_VIEW_3D);
			}else {
				spriteController = new BaseSpriteController(ViewConstants.GAME_VIEW);
				awayController = new BaseAway3DController(ViewConstants.GAME_VIEW_3D)
			}
			ViewController.init(stage, [awayController, spriteController]);
			if(!startUpData.useStarling) ViewController.start();
		}
		
	}

}