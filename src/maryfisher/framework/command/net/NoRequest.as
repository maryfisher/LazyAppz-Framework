package net {
	import maryfisher.framework.command.net.NetRequest;
	import maryfisher.framework.data.NetData;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class NoRequest extends NetRequest {
		
		public function NoRequest() {
			
		}
		
		override public function execute(requestData:Object, netData:NetData, requestSpecs:String):void {
			super.execute(requestData, netData, requestSpecs);
			
			finishRequest(null);
		}
		
		override public function get requestType():String {
			return TYPE_NONE;
		}
	}

}