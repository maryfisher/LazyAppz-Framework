package maryfisher.framework.command.net {
	import flash.net.NetConnection;
	import maryfisher.framework.data.NetData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AMFRequest extends NetRequest {
		
		private var _connection:NetConnection;
		
		public function AMFRequest() {
			super();
			
		}
		
		override public function execute(requestData:Object, netData:NetData, requestSpecs:String):void {
			super.execute(requestData, netData, requestSpecs);
			
			_connection.call.apply(this, []);
				//[_lastRequest.className + "." + _lastRequest.methodName, _responder].concat(_lastRequest.parameters));
		}
		
		public function set connection(value:NetConnection):void {
			_connection = value;
		}
	}

}