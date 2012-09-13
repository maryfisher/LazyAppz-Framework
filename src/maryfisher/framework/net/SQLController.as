package maryfisher.framework.net {
	import maryfisher.framework.command.net.NetCommand;
	import maryfisher.framework.command.net.NetRequest;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SQLController implements INetController {
		
		/** TODO
		 * database location, encryption
		 */
		
		public function SQLController() {
			
		}
		
		/* INTERFACE maryfisher.framework.net.INetController */
		
		public function registerRequest(cmd:NetCommand):void {
			cmd.sendRequest();
		}
		
		public function get requestType():String {
			return "sql";
		}
		
	}

}