package maryfisher.framework.net {
	import flash.net.NetConnection;
	import maryfisher.framework.command.net.AMFRequest;
	import maryfisher.framework.command.net.NetCommand;
	import maryfisher.framework.command.net.NetRequest;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseAMFController implements INetController {
		
		private var _controllerID:String;
		private var _connection:NetConnection;
		private var _gatewayUrl:String;
		
		public function BaseAMFController(controllerID:String) {
			_controllerID = controllerID;
			
			_connection = new NetConnection();
		}
		
		public function connect(): Boolean {
			if (!_connection.connected) {
				_connection.connect(_gatewayUrl);
			}

			return _connection.connected;
		}
		
		/* INTERFACE maryfisher.framework.net.INetController */
		
		public function get controllerID():String {
			return _controllerID;
		}
		
		public function get requestType():String {
			return NetRequest.TYPE_AMF;
		}
		
		public function registerRequest(cmd:NetCommand):void {
			var r:AMFRequest = (cmd.netRequest as AMFRequest);
			r.path = _path;
			r.connection = _connection;
			cmd.sendRequest();
		}
		
	}

}