package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SQLRequestData {
		
		public var requestId:String;
		public var requestString:String;
		
		public function SQLRequestData(requestId:String, requestString:String) {
			this.requestString = requestString;
			this.requestId = requestId;
			
		}
		
	}

}