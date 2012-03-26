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
		
		private var _updateSignal:Signal;
		private var _status:String;
		private var _signature:Class; /* eg IThisModelProxy */
		
		public function AbstractModel() {
			_updateSignal = new Signal(BaseModelUpdate);
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
			_updateSignal.dispatch(new BaseModelUpdate(_status, _signature));
		}
		
		public function set signature(value:Class):void {
			_signature = value;
		}
		
		protected function getBaseUpdate(id:String):BaseModelUpdate {
			return new BaseModelUpdate(id, _signature);
		}
		
		public function dispatch(update:BaseModelUpdate):void {
			_updateSignal.dispatch(update);
		}
	}

}