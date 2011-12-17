package maryfisher.framework.command {
	import maryfisher.framework.core.CommandController;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractCommand{
		
		public function AbstractCommand() {
		}
		
		protected function execute():void {
			CommandController.registerCommand(this);
		}
	}

}