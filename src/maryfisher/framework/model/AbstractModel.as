package maryfisher.framework.model {
	import avmplus.getQualifiedClassName;
	import flash.utils.Dictionary;
	import maryfisher.framework.command.CommandSequencer;
	import maryfisher.framework.command.net.INetRequestCallback;
	import maryfisher.framework.command.net.NetCommand;
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractModel implements INetRequestCallback {
		//static public const DATA_READY:String = "modelDataReady";
		public static const DATA_LOADED:String = 'modelDataLoaded';
		public static const DATA_WAITING:String = 'modelDataWaiting';
		static public const INITIAL_DATA:String = "initialData";
		static public const LATEST_DATA:String = "latestData";
		
		private var _updateSignal:DeluxeSignal;
		//private var _updateSignal:Signal;
		private var _status:String;
		private var _sequencer:CommandSequencer;
		private var _sequenceListener:Dictionary;
		protected var _dataType:String;
		//private var _signature:Class; /* eg IThisModelProxy */
		
		public function AbstractModel() {
			_updateSignal = new DeluxeSignal(BaseModelUpdate);
			//_updateSignal = new Signal(BaseModelUpdate);
			_status = DATA_WAITING;
			_dataType = INITIAL_DATA;
		}
		
		public function init():void {
			
			_sequenceListener = new Dictionary();
			_sequencer = new CommandSequencer();
		}
		
		protected function addNetCommand(id:String, onComplete:Function, requestData:Object = null, requestSpecs:String = ""):void {
			_sequenceListener[id] = onComplete;
			_sequencer.addCommand(new NetCommand(id, requestData, this, requestSpecs, false));
		}
		
		protected function startSequencer(doWaiting:Boolean = true):void {
			if(doWaiting) _status = DATA_WAITING;
			_sequencer.finishedExecutionSignal.addOnce(onFinished);
			_sequencer.execute();
		}
		
		protected function onFinished():void {
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
			_updateSignal.addWithPriority(abstractProxy.updateFromModel, abstractProxy.priority);
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
		
		public function get dataType():String {
			return _dataType;
		}
	}

}