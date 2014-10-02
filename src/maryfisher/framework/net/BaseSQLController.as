package maryfisher.framework.net {
	import adobe.utils.CustomActions;
	import flash.data.SQLConnection;
	import flash.data.SQLTransactionLockType;
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
			_connection.addEventListener(SQLEvent.BEGIN, onBegin);
			_connection.addEventListener(SQLEvent.COMMIT, onCommit);
			
			createDBFile();
		}
		
		private function onBegin(e:SQLEvent):void {
			trace("[BaseSQLController] onBegin -> sendNextRequest")
			sendNextRequest();
		}
		
		private function onOpenError(e:SQLErrorEvent):void {
			// If a transaction is happening, roll it back
            if (_connection.inTransaction)
            {
                _connection.addEventListener(SQLEvent.ROLLBACK, onRollback);
                _connection.rollback();
            }
            
            trace("[BaseSQLController]", e.error.message);
            trace("[BaseSQLController]", e.error.details);
		}
        
        // Called after the transaction is committed
        private function onCommit(event:SQLEvent):void
        {
			if (_pendingRequests.length == 0) {
				_connection.close();
			}
            //_connection.removeEventListener(SQLEvent.COMMIT, onCommit);
            
            trace("[BaseSQLController] commitHandler: Transaction complete");
        }
        
        // Called when the transaction is rolled back
        private function onRollback(event:SQLEvent):void
        {
            _connection.removeEventListener(SQLEvent.ROLLBACK, onRollback);
            
            // add additional error handling, close the database, etc.
        }
		
		private function onDatabaseOpen(e:SQLEvent):void {
			_connection.begin(SQLTransactionLockType.IMMEDIATE);
			//sendNextRequest();
		}
		
		private function onRequestFinished(cmd:NetCommand):void {
			sendNextRequest();
		}
		
		private function sendNextRequest():void {
			var cmd:NetCommand = _pendingRequests.shift();
			if (!cmd) {
				trace("[BaseSQLController] sendNextRequest: Commit transaction");
				//_connection.close();
				_connection.commit();
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
			var resources:File = File.documentsDirectory;
			var ssc:File = new File(resources.nativePath + _path);
			ssc.createDirectory();
			_dbFile = ssc.resolvePath(_dbFileId);
			//throw new Error("[BaseSQLController] createDBFile: Please overwrite this method!")
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