package maryfisher.framework.command.net {
	import flash.net.NetConnection;
	import flash.net.Responder;
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
			
			var responder:Responder = new Responder(onResult, onStatus);
			_connection.call.apply(this, [netData.id, responder].concat(requestData.params));
				//[_lastRequest.className + "." + _lastRequest.methodName, _responder].concat(_lastRequest.parameters));
		}
		
		private function onStatus(result:Object):void {
			for (var i:String in result) {
				trace(result[i]);
			}
		}
		
		private function onResult(result:Object):void {
			
		}
		
		public function set connection(value:NetConnection):void {
			_connection = value;
		}
		
		override public function get requestType():String {
			return TYPE_AMF;
		}
	}

}