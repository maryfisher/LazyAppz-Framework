package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class NetData {
		
		public var id:String;
		public var url:String;
		public var format:String; // JSON oder file system => Wrapper notwendig
		
		public function NetData(url:String, format:String = "json") {
			this.format = format;
			this.url = url;
			//this.id = id;
			
		}
		
	}

}