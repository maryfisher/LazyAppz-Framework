package maryfisher.framework.net {
	import flash.utils.Dictionary;
	import maryfisher.framework.command.net.JSONRequest;
	import maryfisher.framework.command.net.NetCommand;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseJSONController implements INetController {
		
		/** TODO
		 * bundle requests
		 * also specs, like baseurl, hash ect
		 */
		
		
		//private	const BASE_URL:String = "http://localhost/SSC/game/backend/";
		private	var _baseUrl:String = "";
		private var _urls:Dictionary;
		
		public function BaseJSONController(baseUrl:String, urls:Dictionary) {
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
		
		protected function setUrl(r:JSONRequest):void {
			//r.url = JSONConstants[cmd.netData.id];
		}
		
		/* INTERFACE maryfisher.framework.net.INetController */
		
		public function get requestType():String {
			return "json";
		}
		
	}

}