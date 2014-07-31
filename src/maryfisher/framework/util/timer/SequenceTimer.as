package maryfisher.framework.util.timer {
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SequenceTimer {
		
		private var _steps:Vector.<Function>;
		private var _frameLimit:int;
		private var _startTime:int;
		private var _timer:Timer;
		private var _isRunning:Boolean;
		
		public function SequenceTimer(frameLimit:int = 30) {
			_frameLimit = frameLimit;
			_steps = new Vector.<Function>();
		}
		
		public function addStep(step:Function):void {
			_steps.push(step);
		}
		
		public function stepFinished():void {
			_isRunning = false;
			if (((getTimer() - _startTime) < _frameLimit)) {
				nextStep();
			}
		}
		
		public function startSteps():void {
			_timer = new Timer(_frameLimit, 0);
			_timer.addEventListener(TimerEvent.TIMER, onInterval);
			_timer.start();
		}
		
		private function onInterval(event:TimerEvent = null):void {
			if (_isRunning) return;
			_startTime = getTimer();
			nextStep();
		}
		
		private function nextStep():void {
			_isRunning = true;
			var currStep:Function = _steps.pop();
			if (currStep) {
				currStep();
				return;
			}
			
			_timer.stop();
		}
	}

}