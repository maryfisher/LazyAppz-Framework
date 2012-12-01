package maryfisher.framework.command {
	import maryfisher.framework.command.view.SequenceProgress;
	import maryfisher.framework.core.LoaderController;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class CommandSequencer extends AbstractCommand{
		private var _commands:Vector.<AbstractCommand>;
		private var _sequenceProgress:SequenceProgress;
		
		public function CommandSequencer() {
			_commands = new Vector.<AbstractCommand>();
		}
		
		public function addCommand(cmd:AbstractCommand):void {
			_commands.push(cmd);
		}
		
		override public function execute():void {
			nextCommand();
		}
		
		private function onCommandFinished():void {
			nextCommand();
		}
		
		private function nextCommand():void {
			var s:AbstractCommand = _commands.shift();
			if (!s) {
				_finishedExecutionSignal.dispatch();
				return;
			}
			s.finishedExecutionSignal.addOnce(onCommandFinished);
			s.execute();
		}
		
		//public function startSequence():void {
			//LoaderController.registerSequence(this);
		//}
	}

}