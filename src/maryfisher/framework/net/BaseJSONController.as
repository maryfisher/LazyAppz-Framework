package maryfisher.framework.net {
	import flash.utils.Dictionary;
	import maryfisher.framework.command.net.JSONRequest;
	import maryfisher.framework.command.net.NetCommand;
	import maryfisher.framework.command.net.NetRequest;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseJSONController implements INetController {
		
		/** TODO
		 * bundle requests
		 * also specs, like baseurl, hash ect
		 */
		
		private	var _baseUrl:String = "";
		private var _urls:Dictionary;
		private var _controllerID:String;
		
		public function BaseJSONController(baseUrl:String, urls:Dictionary, controllerID:String) {
			_controllerID = controllerID;
			_baseUrl = baseUrl;
			_urls = urls;
			
		}
		
		/* INTERFACE maryfisher.framework.net.INetController */
		
		public function registerRequest(cmd:NetCommand):void {
			var r:JSONRequest = (cmd.netRequest as JSONRequest);
			r.baseUrl = _baseUrl;
			if (!r.url || r.url == "") {
				r.url = _urls[cmd.netData.id];
			}
			
			cmd.sendRequest();
		}
		
		public function get controllerID():String {
			return _controllerID;
		}
		
		protected function setUrl(r:JSONRequest):void {
			//r.url = JSONConstants[cmd.netData.id];
		}
		
		public function get requestType():String {
			return NetRequest.TYPE_JSON;
		}
		
	}

}