package maryfisher.framework.command.net {
	import flash.events.NetDataEvent;
	import maryfisher.framework.command.AbstractCommand;
	import maryfisher.framework.core.NetController;
	import maryfisher.framework.data.NetData;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class NetRequest {
		
		private var _id:String;
		protected var _netData:NetData;
		protected var _requestFinished:Signal;
		protected var _resultData:Object;
		
		public function NetRequest(id:String, callback:INetRequestCallback) {
			_id = id;
			_requestFinished = new Signal(NetRequest);
			_requestFinished.addOnce(callback.onRequestReceived);
			execute();
		}
		
		public function execute():void {
			NetController.registerCommand(this);
		}
		
		public function sendRequest(netData:NetData):void {
			_netData = netData;
			
		}
		
		protected function finishRequest():void {
			_requestFinished.dispatch(this);
		}
		
		public function get requestFinished():Signal { return _requestFinished; }
		public function get id():String { return _id; }
		public function get resultData():Object { return _resultData; }
	}

}