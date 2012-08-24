package maryfisher.framework.command.net.sql {
	import maryfisher.framework.command.AbstractCommand;
	import maryfisher.framework.command.net.INetRequestCallback;
	import maryfisher.framework.command.net.NetRequest;
	import maryfisher.framework.data.NetData;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SQLRequest extends NetRequest {
		
		public function SQLRequest() {
			
		}
		
		override public function execute(data:Object, netData:NetData, requestSpecs:String):void {
			super.sendRequest(data, netData, requestSpecs);
		}
	}

}