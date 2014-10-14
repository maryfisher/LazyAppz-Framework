package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LocaleTextParameter {
		public var id:String;
		public var indexOrig:int;
		public var indexFormatted:int;
		public var content:XML;
		
		public function LocaleTextParameter(id:String, content:XML, indexFormatted:int, indexOrig:int) {
			this.id = id;
			this.indexOrig = indexOrig;
			this.indexFormatted = indexFormatted;
			this.content = content;
			
		}
		
		//public function getAttribute(att:String):* {
			//return content.@att
		//}
	}

}