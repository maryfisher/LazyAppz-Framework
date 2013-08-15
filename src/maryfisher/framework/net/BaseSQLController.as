package maryfisher.framework.net {
	import maryfisher.framework.command.net.NetCommand;
	import maryfisher.framework.command.net.NetRequest;
	import maryfisher.framework.command.net.SQLRequest;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSQLController implements INetController {
		
		private var _dbFileId:String;
		private var _path:String;
		private var _controllerID:String;
		
		/** TODO
		 * database location, encryption
		 */
		
		public function BaseSQLController(path:String, dbFileId:String, controllerID:String) {
			_controllerID = controllerID;
			_path = path;
			_dbFileId = dbFileId;
			
		}
		
		/* INTERFACE maryfisher.framework.net.INetController */
		
		public function registerRequest(cmd:NetCommand):void {
			var r:SQLRequest = (cmd.netRequest as SQLRequest);
			r.path = _path;
			r.dbFile = _dbFileId;
			cmd.sendRequest();
		}
		
		/* INTERFACE maryfisher.framework.net.INetController */
		
		public function get controllerID():String {
			return _controllerID;
		}
		
		public function get requestType():String {
			return NetRequest.TYPE_SQLLITE;
		}
		
	}

}