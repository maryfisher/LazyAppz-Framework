package maryfisher.framework.command {
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractCommand {
		
		protected var _finishedExecutionSignal:Signal;
		
		public function AbstractCommand() {
			_finishedExecutionSignal = new Signal();
		}
		
		public function execute():void {
			
		}
		
		public function get finishedExecutionSignal():Signal {
			return _finishedExecutionSignal;
		}
	}

}