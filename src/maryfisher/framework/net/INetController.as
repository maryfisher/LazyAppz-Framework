package maryfisher.framework.net {
	import maryfisher.framework.command.net.NetCommand;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface INetController {
		function registerRequest(cmd:NetCommand):void;
		function get controllerID():String;
		function get requestType():String;
	}
	
}