package maryfisher.framework.command {
	import maryfisher.framework.core.LoaderController;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class CommandSequencer extends AbstractCommand{
		private var _commands:Vector.<AbstractCommand>;
		
		public function CommandSequencer() {
			_commands = new Vector.<AbstractCommand>();
		}
		
		public function addCommand(cmd:AbstractCommand):void {
			_commands.push(cmd);
		}
		
		override public function execute():void {
			
		}
		
		public function startSequence():void {
			LoaderController.registerSequence(this);
		}
		
		/* TODO
		 * Integration with LoaderController
		 */
		public function getProgress():Number {
			return 0;
		}
	}

}