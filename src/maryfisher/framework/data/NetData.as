package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class NetData {
		
		//public var url:String;
		//public var format:String; // JSON oder file system => Wrapper notwendig
		public var id:String;
		public var requestClass:Class;
		public var requestType:String;
		
		public function NetData(id:String, requestType:String, requestClass:Class = null) {
			this.requestType = requestType;
			this.requestClass = requestClass;
			//this.url = url;
			this.id = id; //für url Zwecke
			
		}
		
	}

}