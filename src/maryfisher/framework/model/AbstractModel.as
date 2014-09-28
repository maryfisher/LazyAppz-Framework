package maryfisher.framework.model {
	import avmplus.getQualifiedClassName;
	import flash.utils.Dictionary;
	import maryfisher.framework.command.CommandSequencer;
	import maryfisher.framework.command.net.INetRequestCallback;
	import maryfisher.framework.command.net.NetCommand;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractModel implements INetRequestCallback {
		//static public const DATA_READY:String = "modelDataReady";
		public static const DATA_LOADED:String = 'modelDataLoaded';
		public static const DATA_WAITING:String = 'modelDataWaiting';
		
		private var _updateSignal:Signal;
		private var _status:String;
		private var _sequencer:CommandSequencer;
		private var _sequenceListener:Dictionary;
		protected var _dataType:String;
		//private var _signature:Class; /* eg IThisModelProxy */
		
		public function AbstractModel() {
			_updateSignal = new Signal(BaseModelUpdate);
			_status = DATA_WAITING;
		}
		
		public function init():void {
			
			_sequenceListener = new Dictionary();
			_sequencer = new CommandSequencer();
		}
		
		protected function addNetCommand(id:String, onComplete:Function, requestData:Object = null):void {
			_sequenceListener[id] = onComplete;
			_sequencer.addCommand(new NetCommand(id, requestData, this, "", false));
		}
		
		protected function startSequencer():void {
			_status = DATA_WAITING;
			_sequencer.finishedExecutionSignal.addOnce(onFinished);
			_sequencer.execute();
		}
		
		private function onFinished():void {
			status = DATA_LOADED;
		}
		
		public function resetData():void {
			_status = DATA_WAITING;
		}
		
		/* INTERFACE maryfisher.framework.command.net.INetRequestCallback */
		
		public function onRequestReceived(cmd:NetCommand):void {
			_sequenceListener[cmd.id](cmd);
		}
		
		public function registerForUpdate(abstractProxy:AbstractModelProxy):void {
			_updateSignal.add(abstractProxy.updateFromModel);
		}
		
		public function unregisterForUpdate(abstractProxy:AbstractModelProxy):void {
			_updateSignal.remove(abstractProxy.updateFromModel);
		}
		
		public function get status():String {
			return _status;
		}
		
		public function set status(status:String):void {
			_status = status;
			_updateSignal.dispatch(new ModelStatusUpdate(_status, _dataType));
		}
		
		//public function set signature(value:Class):void {
			//_signature = value;
		//}
		
		protected function getBaseUpdate(id:String):BaseModelUpdate {
			return new BaseModelUpdate(id);
		}
		
		public function dispatch(update:BaseModelUpdate):void {
			if (_status == DATA_WAITING) return;
			_updateSignal.dispatch(update);
		}
		
		public function get className():String {
			return getQualifiedClassName(this);
		}
	}

}