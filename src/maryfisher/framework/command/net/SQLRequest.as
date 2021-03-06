package maryfisher.framework.command.net {
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import maryfisher.framework.command.net.NetRequest;
	import maryfisher.framework.data.NetData;
	import maryfisher.framework.data.NetResultData;
	
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
        static protected const INT_PRIM:String = INTEGER + PRIMARY_KEY;
        static protected const INT_PRIM_AUT:String = INTEGER + PRIMARY_KEY + AUTOINCREMENT;
		
		static protected const LEFT_OUTER_JOIN:String = " LEFT OUTER JOIN ";
		static protected const CROSS_JOIN:String = " CROSS JOIN ";
		static protected const INNER_JOIN:String = " INNER JOIN ";
		
		protected var _connection:SQLConnection;
		protected var _statement:SQLStatement;
		protected var _requestData:Object;
		protected var _result:SQLResult;
		protected var _resultData:Array;
		
		public function SQLRequest() {
			
		}
		
		override public function execute(data:Object, netData:NetData, requestSpecs:String):void {
			super.execute(data, netData, requestSpecs);
			_requestData = data;
			
			sendRequest();
		}
		
		protected function sendRequest():void {
			
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
		
		protected function deleteStatement(table:String, where:String):String {
			return "DELETE FROM " + table + " WHERE " + where;
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
		
		protected function insertRowStatement(table:String, columns:Array, inserts:Array, doReplace:Boolean = false):String {
			
			var st:String = "INSERT";
			doReplace && (st += " OR REPLACE");
			st += " INTO " + table + " SELECT ";
			
			var c:int = columns.length;
			for (var j:int = 0; j < c; j++) {
				if(inserts[0][j] is String){
					st += "'" + inserts[0][j] + "'";
				}else{
					st += inserts[0][j];
				}
				st += " AS " + columns[j];
				if (j < c - 1) {
					st += ", ";
				}else {
					st += " ";
				}
			}
			
			var l:uint = inserts.length;
			for (var i:int = 1; i < l; i++) {
				st += "UNION SELECT ";
				for (j = 0; j < c; j++) {
					if(inserts[i][j] is String){
						st += "'" + inserts[i][j] + "'";
					}else{
						st += inserts[i][j];
					}
					if (i != l - 1) {
						st += ", ";
					}else {
						st += " ";
					}
				}
			}
			
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
        
        protected function tableInfo(table:String):String {
            return "PRAGMA table_info(" + table + ")";
        }
        
        protected function userVersion():String {
            return "PRAGMA user_version";
        }
		
		protected function createStatement(text:String, onResult:Function = null ):void {
			if (onResult == null) onResult = onCreate;
			_statement = new SQLStatement();
			_statement.text = text;
			trace("[SQLRequest] [createStatement]", text);
			_statement.sqlConnection = _connection;
			_statement.addEventListener(SQLEvent.RESULT, onResult);
			_statement.addEventListener(SQLErrorEvent.ERROR, onError);
			_statement.execute();
		}
		
		protected function onCreate(e:SQLEvent):void {
			_result = _statement.getResult();
			_resultData = _result.data;
		}
		
		private function onError(e:SQLErrorEvent):void {
			trace("[SQLRequst] onError", e.error);
			finishRequest(new NetResultData(false, null, e.error.message));
		}
		
		protected function onSuccess(e:SQLEvent):void {
			finishRequest(new NetResultData(true));
		}
		
		public function set connection(value:SQLConnection):void {
			_connection = value;
		}
	}

}