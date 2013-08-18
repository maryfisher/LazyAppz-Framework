package maryfisher.framework.net {
	import flash.utils.Dictionary;
	import maryfisher.framework.command.net.JSONRequest;
	import maryfisher.framework.command.net.NetCommand;
	import maryfisher.framework.command.net.NetRequest;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseJSONController extends BaseURLController implements INetController {
		
		/** TODO
		 * bundle requests
		 * also specs, like baseurl, hash ect
		 */
		
		public function BaseJSONController(baseUrl:String, urls:Dictionary, controllerID:String) {
			super(baseUrl, urls, controllerID);
		}
		
		/* INTERFACE maryfisher.framework.net.INetController */
		
		//public function registerRequest(cmd:NetCommand):void {
			//var r:JSONRequest = (cmd.netRequest as JSONRequest);
			//r.baseUrl = _baseUrl;
			//if (!r.url || r.url == "") {
				//r.url = _urls[cmd.netData.id];
			//}
			//
			//cmd.sendRequest();
		//}
		
		protected function setUrl(r:JSONRequest):void {
			//r.url = JSONConstants[cmd.netData.id];
		}
		
		override public function get requestType():String {
			return NetRequest.TYPE_JSON;
		}
		
	}

}