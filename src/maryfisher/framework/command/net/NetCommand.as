package maryfisher.framework.command.net {
	import maryfisher.framework.command.AbstractCommand;
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
		private var _netRequest:NetRequest;
		protected var _netData:NetData;
		protected var _requestFinished:Signal;
		protected var _resultData:Object;
		protected var _requestData:Object;
		
		public function NetCommand(id:String, requestData:Object, callback:INetRequestCallback = null, requestSpecs:String = "") {
			_requestSpecs = requestSpecs;
			_requestData = requestData;
			_id = id;
			_requestFinished = new Signal(NetCommand);
			callback && _requestFinished.addOnce(callback.onRequestReceived);
			execute();
		}
		
		public function execute():void {
			NetController.registerCommand(this);
		}
		
		public function buildRequest(netData:NetData):void {
			_netData = netData;
			
			_netRequest;
			if (!_netData.requestClass) {
				throw new Error("No request class specified!");
				return;
			}
				
			_netRequest = new _netData.requestClass();
			_netRequest.requestFinished.addOnce(finishRequest);
			
		}
		
		public function sendRequest():void {
			_netRequest.execute(_requestData, _netData, _requestSpecs);
		}
		
		
		
		protected function finishRequest(data:Object):void {
			_resultData = data;
			_requestFinished.dispatch(this);
		}
		
		public function get requestFinished():Signal { return _requestFinished; }
		public function get id():String { return _id; }
		public function get resultData():Object { return _resultData; }
		
		public function get netRequest():NetRequest {
			return _netRequest;
		}
		
		public function get netData():NetData {
			return _netData;
		}
	}

}