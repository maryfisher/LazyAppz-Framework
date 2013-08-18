package maryfisher.framework.net {
	import flash.utils.Dictionary;
	import maryfisher.framework.command.net.NetCommand;
	import maryfisher.framework.command.net.NetRequest;
	import maryfisher.framework.command.net.XMLRequest;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseXMLController extends BaseURLController implements INetController {
		
		public function BaseXMLController(baseUrl:String, urls:Dictionary, controllerID:String) {
			super(baseUrl, urls, controllerID);
			
		}
		
		override public function get requestType():String {
			return NetRequest.TYPE_XML;
		}
		
	}

}