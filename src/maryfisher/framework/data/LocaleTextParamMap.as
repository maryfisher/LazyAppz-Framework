package maryfisher.framework.data {
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LocaleTextParamMap {
		
		public var links:Dictionary;
		public var cssClasses:Dictionary;
		
		public function LocaleTextParamMap() {
			cssClasses = new Dictionary();
		}
		
		public function addMap(map:LocaleTextParamMap):void {
			for (var key:String in map.cssClasses) {
				cssClasses[key] = map.cssClasses[key];
			}
		}
		
		public function mapTypeToClass(type1:String, type2:String, cssClass:String):void {
			cssClasses[type1 + "='" + type2 + "'"];
		}
		
		public function getLink(paramType1:String, paramType2:String):String {
			return "";
		}
		
		public function getCssClass(paramType1:String, paramType2:String):String {
			return cssClasses[paramType1 + "='" + paramType2 + "'"];
		}
	}

}