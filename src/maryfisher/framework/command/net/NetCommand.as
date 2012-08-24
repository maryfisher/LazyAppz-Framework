package maryfisher.framework.command.net {
	import flash.events.NetDataEvent;
	import maryfisher.framework.command.AbstractCommand;
	import maryfisher.framework.command.net.sql.SQLRequest;
	import maryfisher.framework.core.NetController;
	import maryfisher.framework.data.NetData;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class NetCommand {
		
		private var _id:String;
		private var _requestSpecs:String;
		protected var _netData:NetData;
		protected var _requestFinished:Signal;
		protected var _resultData:Object;
		protected var _requestData:Object;
		
		public function NetCommand(id:String, requestData:Object, callback:INetRequestCallback, requestSpecs:String = "") {
			_requestSpecs = requestSpecs;
			_requestData = requestData;
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
			
			var requ:NetRequest;
			if (!_netData.requestClass) {
				throw new Error("No request class specified!");
				return;
			}
				
			requ = new _netData.requestClass();
			requ.requestFinished.addOnce(finishRequest);
			requ.execute(_requestData, _netData, _requestSpecs);
		}
		
		protected function finishRequest(data:Object):void {
			_resultData = data;
			_requestFinished.dispatch(this);
		}
		
		public function get requestFinished():Signal { return _requestFinished; }
		public function get id():String { return _id; }
		public function get resultData():Object { return _resultData; }
	}

}