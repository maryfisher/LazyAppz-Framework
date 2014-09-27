package maryfisher.framework.net {
	import adobe.utils.CustomActions;
	import flash.data.SQLConnection;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
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
		private var _connection:SQLConnection;
		private var _pendingRequests:Vector.<NetCommand>;
		
		/** TODO
		 * database location, encryption
		 */
		
		public function BaseSQLController(path:String, dbFileId:String, controllerID:String) {
			_controllerID = controllerID;
			_path = path;
			_dbFileId = dbFileId;
			
			_pendingRequests = new Vector.<NetCommand>();
			
			_connection = new SQLConnection();
			_connection.addEventListener(SQLEvent.OPEN, onDatabaseOpen);
			_connection.addEventListener(SQLErrorEvent.ERROR, onOpenError);
			
			createDBFile();
		}
		
		private function onOpenError(e:SQLErrorEvent):void {
			trace("[BaseSQLController]", e.error);
		}
		
		private function onDatabaseOpen(e:SQLEvent):void {
			sendNextRequest();
		}
		
		private function onRequestFinished(cmd:NetCommand):void {
			sendNextRequest();
		}
		
		private function sendNextRequest():void {
			var cmd:NetCommand = _pendingRequests.shift();
			if (!cmd) {
				_connection.close();
				return;
			}
			var r:SQLRequest = (cmd.netRequest as SQLRequest);
			r.connection = _connection;
			cmd.requestFinished.addOnce(onRequestFinished);
			cmd.sendRequest();
		}
		
		/* INTERFACE maryfisher.framework.net.INetController */
		
		public function registerRequest(cmd:NetCommand):void {
			var r:SQLRequest = (cmd.netRequest as SQLRequest);
			if (!r)
				return;
			_pendingRequests.push(cmd);
			if (_pendingRequests.length > 1)
				return;
			_connection.open(_dbFile, "create", false, 512);
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