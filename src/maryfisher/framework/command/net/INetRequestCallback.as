package maryfisher.framework.command.net {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface INetRequestCallback {
		function onRequestReceived(cmd:NetCommand):void;
	}
	
}