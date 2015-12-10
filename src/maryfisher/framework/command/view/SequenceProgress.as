package maryfisher.framework.command.view {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SequenceProgress extends AbstractProgress{
		
		//protected var _currentStep:int = -1;
		protected var _currentStep:int = 0;
		protected var _steps:int;
		protected var _stepDescriptions:Vector.<String>;
		
		public function SequenceProgress(steps:int, stepDescriptions:Vector.<String> = null) {
			_stepDescriptions = stepDescriptions;
			_steps = steps;
			super();
			//next();
		}
		
		public function next():void {
			_currentStep++;
			getProgress();
		}
		
		override protected function getProgress():void {
			
			setProgress();
			//trace("SequenceProgress: " + _progress, "_currentStep", _currentStep);
			super.getProgress();
		}
		
		override public function getDescription():String {
			if (_stepDescriptions && _currentStep != -1){
				if (_stepDescriptions.length <= _currentStep) {
					return _stepDescriptions[0];
				}
				return _stepDescriptions[_currentStep];
			}
			//trace("Sequence Progress: no description: _currentStep - ", _currentStep);
			return "";
		}
		
		public function addStep(descript:String):void {
			_steps++;
			_stepDescriptions && _stepDescriptions.push(descript);
		}
		
		protected function setProgress():void {
			//_progress = Math.min((_currentStep + 0.5) / _steps, 1);
			_progress = _currentStep / _steps;
			//_progress = Math.min((_currentStep) / _steps, 1);
		}
		
		public function get currentStep():int {
			return _currentStep;
		}
		
		public function get steps():int {
			return _steps;
		}
	}

}