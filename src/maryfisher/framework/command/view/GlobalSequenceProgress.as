package maryfisher.framework.command.view {
	import flash.events.Event;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class GlobalSequenceProgress extends SequenceProgress{
		private var _sequences:Vector.<SequenceProgress>;
		private var _currentSequence:int;
		
		public function GlobalSequenceProgress() {
			super(0);
			_sequences = new Vector.<SequenceProgress>();
			_currentSequence = 0;
		}
		
		//override protected function execute():void {
			//
		//}
		
		public function addSequence(sequence:SequenceProgress):void {
			_sequences.push(sequence);
			sequence.addFinishedListener(onProgress, onFinished);
			_steps = 0;
			for (var i:int = 0; i < _sequences.length; i++ ) {
				_steps += _sequences[i].steps;
			}
		}
		
		private function onFinished(sequence:SequenceProgress):void {
			_currentSequence++;
		}
		
		override protected function setProgress():void {
			_progress = Math.min((_currentStep) / _steps, 1);
		}
		
		private function onProgress(sequence:SequenceProgress):void {
			next();
		}
		
		override public function getDescription():String {
			return _sequences[_currentSequence].getDescription();
		}
		
		public function empty():void {
			_sequences.length = 0;
			_currentSequence = 0;
			_currentStep = 0;
		}
	}

}