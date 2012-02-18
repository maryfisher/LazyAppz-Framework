package maryfisher.framework.command.loader {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SquenceLoader {
		
		private var _loaderCommands:Vector.<LoaderCommand>;
		private var _autoPlay:Boolean;
		
		public function SquenceLoader() {
			_loaderCommands = new Vector.<LoaderCommand>();
		}
		
		public function addCommand(cmd:LoaderCommand):void {
			_loaderCommands.push(cmd);
		}
		
		public function startSequence(autoPlay:Boolean = true):void {
			_autoPlay = autoPlay;
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
				/* TODO
				 * callback?
				 */
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