package maryfisher.framework.command.net {
	import maryfisher.framework.data.NetData;
	import maryfisher.framework.model.AbstractProxy;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class NetRequest { // extends AbstractProxy{
		
		protected var _requestFinished:Signal;
		
		public function NetRequest() {
			_requestFinished = new Signal(Object);
			super();
		}
		
		public function execute(requestData:Object, netData:NetData, requestSpecs:String):void {
			
		}
		
		protected function finishRequest(data:Object):void {
			_requestFinished.dispatch(data);
		}
		
		public function get requestFinished():Signal {
			return _requestFinished;
		}
		
		public function get requestType():String {
			return "";
		}
	}

}