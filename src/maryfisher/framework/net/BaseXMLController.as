package maryfisher.framework.net {
	import flash.utils.Dictionary;
	import maryfisher.framework.command.net.NetRequest;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseXMLController extends BaseURLController implements INetController {
		
		public function BaseXMLController(baseUrl:String, urls:Dictionary, controllerID:String) {
			super(baseUrl, urls, controllerID);
			
		}
		
	}

}