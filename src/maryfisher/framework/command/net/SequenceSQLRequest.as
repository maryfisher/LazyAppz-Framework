package maryfisher.framework.command.net {
	import flash.events.SQLEvent;
	import maryfisher.framework.data.SQLRequestData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SequenceSQLRequest extends SQLRequest {
		
		protected var _requests:Vector.<SQLRequestData>;
		protected var _currentRequestData:SQLRequestData;
		
		public function SequenceSQLRequest() {
			
		}
		
		override protected function onDatabaseOpen(e:SQLEvent):void {
			_requests = new Vector.<SQLRequestData>();
			
			
		}
		
		protected function addRequest(id:String, table:String, select:String = "*", where:String = "", order:String = ""):void {
			_requests.push(new SQLRequestData(id, selectStatement(table, select, where, order)));
		}
		
		protected function nextRequest():void {
			
			if (_requests.length == 0) {
				lastRequest();
				return;
			}
			
			_currentRequestData = _requests.pop();
			createStatement(_currentRequestData.requestString);
		}
		
		protected function lastRequest():void {
			
		}
		
	}

}