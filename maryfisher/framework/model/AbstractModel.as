package maryfisher.framework.model {
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractModel{
		//static public const DATA_READY:String = "modelDataReady";		
		public static const DATA_LOADED:String = 'modelDataLoaded';
		public static const DATA_WAITING:String = 'modelDataWaiting';
		
		protected var _updateSignal:Signal;
		protected var _status:String;
		
		public function AbstractModel() {
			_updateSignal = new Signal(String);
			_status = DATA_WAITING;
		}
		
		public function registerForUpdate(abstractProxy:AbstractProxy):void {
			_updateSignal.add(abstractProxy.updateFromModel);
		}
		
		public function unregisterForUpdate(abstractProxy:AbstractProxy):void {
			_updateSignal.remove(abstractProxy.updateFromModel);
		}
		
		public function get status():String {
			return _status;
		}
		
		public function set status(value:String):void {
			_status = value;
			_updateSignal.dispatch(_status);
		}
		
		public function dispatch(cmd:String):void {
			_updateSignal.dispatch(cmd);
		}
	}

}