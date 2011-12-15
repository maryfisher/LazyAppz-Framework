package controller.command.global {
	import controller.core.CommandController;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class GlobalCommand{
		
		public function GlobalCommand() {
		}
		
		protected function execute():void {
			CommandController.registerCommand(this);
		}
	}

}