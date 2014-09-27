package maryfisher.framework.net {
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import maryfisher.framework.command.net.AMFRequest;
	import maryfisher.framework.command.net.NetCommand;
	import maryfisher.framework.command.net.NetRequest;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseAMFController implements INetController {
		
		private const NETCONNECTION_CONNECT_FAILED: String = "NetConnection.Connect.Failed";
		private const NETCONNECTION_CALL_FAILED: String = "NetConnection.Call.Failed";
		private const NETCONNECTION_CALL_BADVERSION: String = "NetConnection.Call.BadVersion";
		
		private var _controllerID:String;
		private var _connection:NetConnection;
		private var _gatewayUrl:String;
		
		public function BaseAMFController(gatewayUrl:String, controllerID:String) {
			_gatewayUrl = gatewayUrl;
			_controllerID = controllerID;
			
			_connection = new NetConnection();
			_connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncErrorEvent);
			_connection.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorEvent);
			_connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorEvent);
			_connection.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusEvent);
		}

		private function onNetStatusEvent(event: NetStatusEvent): void {
			switch (event.info.code) {
				case NETCONNECTION_CONNECT_FAILED:
					trace("Connection failed!");
					break;

				case NETCONNECTION_CALL_FAILED:
					trace("Calling service failed!");
					break;

				case NETCONNECTION_CALL_BADVERSION:
					trace("Server Script Error!");
					break;
			}
		}

		private function onAsyncErrorEvent(event: AsyncErrorEvent): void {
			trace(event.text);
		}

		private function onIOErrorEvent(event: IOErrorEvent): void {
			trace(event.text);
		}

		private function onSecurityErrorEvent(event: SecurityErrorEvent): void {
			trace(event.text);
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
			r.connection = _connection;
			connect();
			cmd.sendRequest();
		}
		
	}

}