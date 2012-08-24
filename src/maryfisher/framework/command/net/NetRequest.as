package maryfisher.framework.command.net {
	import maryfisher.framework.data.NetData;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class NetRequest {
		
		protected var _requestFinished:Signal;
		
		public function NetRequest() {
			
		}
		
		public function execute(requestData:Object, netData:NetData, requestSpecs:String):void {
			
		}
		
		private function finishRequest(data:Object):void {
			_requestFinished.dispatch(data);
		}
		
		public function get requestFinished():Signal {
			return _requestFinished;
		}
	}

}