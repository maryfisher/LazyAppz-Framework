package maryfisher.framework.command {
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractCommand {
		
		protected var _finishedExecutionSignal:Signal;
		
		public function AbstractCommand(executeImediatly:Boolean = false) {
			_finishedExecutionSignal = new Signal();
			if (executeImediatly)
				execute();
		}
		
		public function execute():void {
			
		}
		
		public function get finishedExecutionSignal():Signal {
			return _finishedExecutionSignal;
		}
	}

}