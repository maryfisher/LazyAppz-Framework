package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LocaleTextParameter {
		public var indexOrig:int;
		public var indexFormatted:int;
		public var content:XML;
		
		public function LocaleTextParameter(content:XML, indexFormatted:int, indexOrig:int) {
			this.indexOrig = indexOrig;
			this.indexFormatted = indexFormatted;
			this.content = content;
			
		}
		
		//public function getAttribute(att:String):* {
			//return content.@att
		//}
	}

}