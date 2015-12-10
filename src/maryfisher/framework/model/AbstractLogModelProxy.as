package maryfisher.framework.model {
	import maryfisher.data.log.ILogProxy;
	import maryfisher.data.log.LogModel;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractLogModelProxy extends AbstractModelProxy implements ILogProxy {
		
		private var _logModel:LogModel;
		
		public function AbstractLogModelProxy(priority:int=0) {
			super(priority);
			
		}
		
		protected function log(...arg):void {
			_logModel.addLogData(this, arg.join(" "));
		}
		
		/* INTERFACE maryfisher.data.log.ILogProxy */
		
		public function set logModel(value:LogModel):void {
			_logModel = value;
		}
		
	}

}