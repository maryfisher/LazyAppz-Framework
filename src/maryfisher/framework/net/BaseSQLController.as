package maryfisher.framework.net {
	import flash.filesystem.File;
	import maryfisher.framework.command.net.NetCommand;
	import maryfisher.framework.command.net.NetRequest;
	import maryfisher.framework.command.net.SQLRequest;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSQLController implements INetController {
		
		protected var _dbFileId:String;
		protected var _dbFile:File;
		protected var _path:String;
		private var _controllerID:String;
		
		/** TODO
		 * database location, encryption
		 */
		
		public function BaseSQLController(path:String, dbFileId:String, controllerID:String) {
			_controllerID = controllerID;
			_path = path;
			_dbFileId = dbFileId;
			
			createDBFile();
		}
		
		/* INTERFACE maryfisher.framework.net.INetController */
		
		public function registerRequest(cmd:NetCommand):void {
			var r:SQLRequest = (cmd.netRequest as SQLRequest);
			if (!r)
				return;
			r.path = _path;
			r.dbFile = _dbFile;
			cmd.sendRequest();
		}
		
		protected function createDBFile():void {
			throw new Error("[BaseSQLController] createDBFile: Please overwrite this method!")
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