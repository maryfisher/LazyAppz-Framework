package maryfisher.framework.command.net {
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.net.dns.SRVRecord;
	import maryfisher.framework.command.AbstractCommand;
	import maryfisher.framework.command.net.INetRequestCallback;
	import maryfisher.framework.command.net.NetRequest;
	import maryfisher.framework.data.NetData;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SQLRequest extends NetRequest {
		
		static protected const TEXT:String = "TEXT";
		static protected const INTEGER:String = "INTEGER";
		static protected const PRIMARY_KEY:String = " PRIMARY KEY";
		static protected const AUTOINCREMENT:String = " AUTOINCREMENT";
		static protected const REAL:String = "REAL";
		static protected const NUMERIC:String = "NUMERIC";
		static protected const BOOLEAN:String = "BOOLEAN";
		static protected const DATE:String = "DATE";
		static protected const XML_TYPE:String = "XML";
		static protected const NONE:String = "NONE";
		
		static protected const LEFT_OUTER_JOIN:String = " LEFT OUTER JOIN ";
		static protected const CROSS_JOIN:String = " CROSS JOIN ";
		static protected const INNER_JOIN:String = " INNER JOIN ";
		
		private var _connection:SQLConnection;
		protected var _requestData:Object;
		protected var _result:SQLResult;
		protected var _resultData:Object;
		protected var _statement:SQLStatement;
		public var path:String;
		public var dbFile:String;
		
		public function SQLRequest() {
			
		}
		
		override public function execute(data:Object, netData:NetData, requestSpecs:String):void {
			super.execute(data, netData, requestSpecs);
			_requestData = data;
			var resources :File = File.documentsDirectory;
			var ssc:File = new File(resources.nativePath + path);
			ssc.createDirectory();
			var dbFile:File = ssc.resolvePath(dbFile + ".sav");
			
			_connection = new SQLConnection();
			_connection.addEventListener(SQLEvent.OPEN, onDatabaseOpen);
			_connection.addEventListener(SQLErrorEvent.ERROR, onOpenError);
			_connection.open(dbFile, "create", false, 512);
			
			
		}
		
		protected function onDatabaseOpen(e:SQLEvent):void {
			
		}
		
		protected function createTable(table:String, names:Array, types:Array):void {
			
			var st:String = "CREATE TABLE IF NOT EXISTS " + table + " (";
			var l:uint = names.length;
			for (var i:int = 0; i < l; i++) {
				st += names[i] + " " + types[i];
				if (i != l - 1) {
					st += ", ";
				}
			}
			
			st += ")";
			
			createStatement(st);
		}
		
		protected function insertStatement(table:String, columns:Array, inserts:Array, doReplace:Boolean = false):String {
			
			var st:String = "INSERT";
			doReplace && (st += " OR REPLACE");
			st += " INTO " + table + " (" + columns.join(",") + ") VALUES (";
			
			var l:uint = inserts.length;
			for (var i:int = 0; i < l; i++) {
				if(inserts[i] is String){
					st += "'" + inserts[i] + "'";
				}else{
					st += inserts[i];
				}
				if (i != l - 1) {
					st += ", ";
				}
			}
			
			st += ")";
			
			return st;
		}
		
		protected function updateStatement(table:String, columns:Array, sets:Array, where:String):String {
			var st:String = "UPDATE " + table + " SET ";
			var l:uint = columns.length;
			for (var i:int = 0; i < l; i++) {
				st += columns[i] + "=";
				if(sets[i] is String){
					st += "'" + sets[i] + "'";
				}else{
					st += sets[i];
				}
				if (i != l - 1) {
					st += ",";
				}
			}
			
			st += " WHERE " + where;
			
			return st;
		}
		
		protected function selectStatement(table:String, select:String = "*", where:String = "", order:String = ""):String {
			var st:String = "SELECT " + select + " FROM " + table;
			if (where != "") {
				st += " WHERE " + where;
			}
			if (order != "") {
				st += " ORDER BY " + order;
			}
			
			return st;
		}
		
		protected function createJoin(table:String, joinTable:String, tableId:String, joinTableId:String, joinType:String):String {
			return joinType + joinTable + " ON " + table + "." + tableId + "=" + joinTable + "." + joinTableId;
		}
		
		protected function createStatement(text:String, onResult:Function = null ):void {
			if (onResult == null) onResult = onCreate;
			_statement = new SQLStatement();
			_statement.text = text;
			trace(text);
			_statement.sqlConnection = _connection;
			_statement.addEventListener(SQLEvent.RESULT, onResult);
			_statement.addEventListener(SQLErrorEvent.ERROR, onError);
			_statement.execute();
		}
		
		protected function onCreate(e:SQLEvent):void {
			_result = _statement.getResult();
			//_resultData = _result.data;
		}
		
		private function onError(e:SQLErrorEvent):void {
			trace(e.error);
		}
		
		private function onOpenError(e:SQLErrorEvent):void {
			trace(e.error);
		}
		
		override public function get requestType():String {
			return TYPE_SQLLITE;
		}
	}

}