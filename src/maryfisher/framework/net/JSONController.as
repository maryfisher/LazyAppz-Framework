package maryfisher.framework.net {
	import coronado.ssc.config.JSONConstants;
	import maryfisher.framework.command.net.JSONRequest;
	import maryfisher.framework.command.net.NetCommand;
	import maryfisher.framework.command.net.NetRequest;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class JSONController implements INetController {
		
		/** TODO
		 * bundle requests
		 * also specs, like baseurl, hash ect
		 */
		
		
		private	const BASE_URL:String = "http://localhost/SSC/game/backend/";
		
		public function JSONController() {
			
		}
		
		/* INTERFACE maryfisher.framework.net.INetController */
		
		public function registerRequest(cmd:NetCommand):void {
			var r:JSONRequest = (cmd.netRequest as JSONRequest);
			r.baseUrl = BASE_URL;
			if (!r.url || r.url == "") {
				r.url = JSONConstants[cmd.netData.id];
			}
			
			cmd.sendRequest();
		}
		
		/* INTERFACE maryfisher.framework.net.INetController */
		
		public function get requestType():String {
			return "json";
		}
		
	}

}