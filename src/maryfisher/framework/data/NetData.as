package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class NetData {
		
		public var id:String;
		public var url:String;
		//public var format:String; // JSON oder file system => Wrapper notwendig
		public var requestClass:Class;
		
		public function NetData(url:String, requestClass:Class = null) {
			this.sqlClass = sqlClass;
			this.format = format;
			this.url = url;
			//this.id = id;
			
		}
		
	}

}