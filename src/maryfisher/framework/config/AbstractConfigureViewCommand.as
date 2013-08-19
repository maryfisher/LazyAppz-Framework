package maryfisher.framework.config {
	import flash.display.Stage;
	import maryfisher.framework.core.KeyController;
	import maryfisher.framework.core.SoundController;
	import maryfisher.framework.core.ViewController;
	
	/**
	 * Helper class to set up view-, keyboard- and sound functionality.
	 * 
	 * Extend this class for your own configurations.
	 * 
	 * @author mary_fisher
	 */
	public class AbstractConfigureViewCommand {
		
		public function AbstractConfigureViewCommand() {
			
		}
		
		public function execute(stage:Stage):void {
			KeyController.init(stage);
			ViewController.init(stage, getViewController());
			
			SoundController.init(getSoundTransforms());
		}
		
		protected function startView():void {
			ViewController.start();
		}
		
		protected function getViewController():Array {
			return [];
		}
		
		protected function getSoundTransforms():Vector.<String> {
			return new Vector.<String>();
		}
	}

}