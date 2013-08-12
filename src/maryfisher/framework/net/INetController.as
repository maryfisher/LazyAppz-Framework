package maryfisher.framework.net {
	import maryfisher.framework.command.net.NetCommand;
	import maryfisher.framework.command.net.NetRequest;
	
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