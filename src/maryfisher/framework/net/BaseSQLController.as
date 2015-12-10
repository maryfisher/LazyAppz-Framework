package maryfisher.framework.net {
	import flash.data.SQLConnection;
	import flash.data.SQLTransactionLockType;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import maryfisher.framework.command.net.NetCommand;
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
		private var _connectionOpen:Boolean;
		private var _isReadOnly:Boolean;
		
		/** TODO
		 * database encryption
		 */
		
		public function BaseSQLController(path:String, dbFileId:String, controllerID:String, isReadOnly:Boolean = true) {
			_isReadOnly = isReadOnly;
			_controllerID = controllerID;
			_path = path;
			_dbFileId = dbFileId;
			
			_pendingRequests = new Vector.<NetCommand>();
			
			_connection = new SQLConnection();
			_connection.addEventListener(SQLEvent.OPEN, onDatabaseOpen);
			_connection.addEventListener(SQLErrorEvent.ERROR, onOpenError);
			if(!_isReadOnly){
				_connection.addEventListener(SQLEvent.BEGIN, onBegin);
				_connection.addEventListener(SQLEvent.COMMIT, onCommit);
			}
			
			createDBFile();
		}
		
		private function onBegin(e:SQLEvent):void {
			//trace("[BaseSQLController] onBegin -> sendNextRequest")
			sendNextRequest();
		}
		
		private function onOpenError(e:SQLErrorEvent):void {
			// If a transaction is happening, roll it back
			if (_connection.inTransaction) {
				_connection.addEventListener(SQLEvent.ROLLBACK, onRollback);
				_connection.rollback();
			}
			
			trace("[BaseSQLController]", e.error.message);
			trace("[BaseSQLController]", e.error.details);
		}
		
		// Called after the transaction is committed
		private function onCommit(event:SQLEvent):void {
			if (_pendingRequests.length == 0) {
				_connection.close();
				_connectionOpen = false;
				//trace("[BaseSQLController] commitHandler: Transaction complete");
			}
			
		}
		
		// Called when the transaction is rolled back
		private function onRollback(event:SQLEvent):void {
			_connection.removeEventListener(SQLEvent.ROLLBACK, onRollback);
		
			// add additional error handling, close the database, etc.
		}
		
		private function onDatabaseOpen(e:SQLEvent):void {
			if (_isReadOnly) {
				sendNextRequest();
				return;
			}
			_connection.begin(SQLTransactionLockType.IMMEDIATE);
		}
		
		private function onRequestFinished(cmd:NetCommand):void {
			sendNextRequest();
		}
		
		private function sendNextRequest():void {
			var cmd:NetCommand = _pendingRequests.shift();
			if (!cmd) {
				//trace("[BaseSQLController] sendNextRequest: Commit transaction");
				if (!_isReadOnly) {
					_connection.commit();
					return;
				}
				_connection.close();
				_connectionOpen = false;
				return;
			}
			//trace("[BaseSQLController] sendNextRequest:", _dbFile.nativePath);
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
			//trace("[BaseSQLController] registerRequest:", cmd.id, "connection open:", _connectionOpen);
			_pendingRequests.push(cmd);
			if (_connectionOpen)
				return;
			_connectionOpen = true;
			_connection.open(_dbFile, "create", false, 512);
		}
		
		protected function createDBFile():void {
			var resources:File = File.documentsDirectory;
			var ssc:File = new File(resources.nativePath + _path);
			ssc.createDirectory();
			_dbFile = ssc.resolvePath(_dbFileId);
		}
		
		/* INTERFACE maryfisher.framework.net.INetController */
		
		public function get controllerID():String {
			return _controllerID;
		}
	
	}

}