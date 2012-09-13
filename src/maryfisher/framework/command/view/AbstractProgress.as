package maryfisher.framework.command.view {
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.core.LoadingViewController;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractProgress extends ViewCommand{
		
		private var _progressSignal:Signal;
		private var _finishedSignal:Signal;
		protected var _progress:Number;
		
		public function AbstractProgress() {
			
			_progressSignal = new Signal(AbstractProgress);
			_finishedSignal = new Signal(AbstractProgress);
			
			super(null, LoadingViewController.ADD_SEQUENCE, LoadingViewController.LOADING_VIEW);
		}
		
		public function addFinishedListener(progress:Function, listener:Function):void {
			_progressSignal.add(progress);
			_finishedSignal.addOnce(listener)
			getProgress();
		}
		
		protected function getProgress():void {
			if (_progress >= 1) {
				_progressSignal.removeAll();
				_finishedSignal.dispatch(this);
				return;
			}
			_progressSignal.dispatch(this);
		}
		
		public function getDescription():String {
			return "";
		}
		
		public function get progress():Number {
			return _progress;
		}
		
		public function toString():String {
			return "[AbstractProgress progress=" + progress + ", description=" + getDescription() + "]";
		}
	}

}