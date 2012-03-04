package maryfisher.framework.command.loader {
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SquenceLoader {
		
		private var _loaderCommands:Vector.<LoaderCommand>;
		private var _autoPlay:Boolean;
		private var _sequenceFinished:Signal;
		
		public function SquenceLoader() {
			_loaderCommands = new Vector.<LoaderCommand>();
			_sequenceFinished = new Signal();
		}
		
		public function addCommand(cmd:LoaderCommand):void {
			_loaderCommands.push(cmd);
		}
		
		public function startSequence(autoPlay:Boolean = true, finishedCallback:Function = null):void {
			_autoPlay = autoPlay;
			if (finishedCallback != null) _sequenceFinished.add(finishedCallback);
			executeCommand();
		}
		
		public function next():void {
			executeCommand();
		}
		
		private function finishedCommand(cmd:LoaderCommand):void {
			if (!_autoPlay) {
				return;
			}
			if (!executeCommand()) {
				_sequenceFinished.dispatch();
			}
		}
		
		private function executeCommand():Boolean {
			if (_loaderCommands.length == 0) {
				return false;
			}
			var cmd:LoaderCommand = _loaderCommands.pop();
			cmd.finishedLoading.add(finishedCommand);
			cmd.execute()
			return true;
		}
	}

}