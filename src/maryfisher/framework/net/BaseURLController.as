package maryfisher.framework.net {
	import flash.utils.Dictionary;
	import maryfisher.framework.command.net.BaseURLRequest;
	import maryfisher.framework.command.net.NetCommand;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseURLController implements INetController {
		
		private var _controllerID:String;
		protected var _baseUrl:String;
		protected var _urls:Dictionary;
		
		public function BaseURLController(baseUrl:String, urls:Dictionary, controllerID:String) {
			_urls = urls;
			_controllerID = controllerID;
			_baseUrl = baseUrl;
		}
		
		/* INTERFACE maryfisher.framework.net.INetController */
		
		public function get controllerID():String {
			return _controllerID;
		}
		
		public function get requestType():String {
			throw new Error("[BaseURLController] - No requestType specfied. Please override this method.");
			return "";
		}
		
		public function registerRequest(cmd:NetCommand):void {
			var r:BaseURLRequest = (cmd.netRequest as BaseURLRequest);
			r.baseUrl = _baseUrl;
			r.url = _urls[cmd.netData.id];
			cmd.sendRequest();
		}
		
	}

}