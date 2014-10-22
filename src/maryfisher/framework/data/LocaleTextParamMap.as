package maryfisher.framework.data {
	
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LocaleTextParamMap {
		
		public var links:Dictionary;
		public var cssClasses:Dictionary;
		public var contents:Dictionary;
		
		public function LocaleTextParamMap() {
			cssClasses = new Dictionary();
			contents = new Dictionary();
			links = new Dictionary();
		}
		
		public function addMap(map:LocaleTextParamMap):void {
			for (var key:String in map.cssClasses) {
				if (cssClasses[key])
					trace("[LocaleTextParamMap] addMap: Key", key, "for cssClasses exists already and is being overridden!");
				cssClasses[key] = map.cssClasses[key];
			}
			for (key in map.contents) {
				if (contents[key])
					trace("[LocaleTextParamMap] addMap: Key", key, "for contents exists already and is being overridden!");
				contents[key] = map.contents[key];
			}
			for (key in map.links) {
				if (links[key])
					trace("[LocaleTextParamMap] addMap: Key", key, "for links exists already and is being overridden!");
				links[key] = map.links[key];
			}
		}
		
		public function addCssClass(type1:String, type2:String, cssClass:String):void {
			cssClasses[type1 + "='" + type2 + "'"] = cssClass;
		}
		
		public function getCssClass(paramType1:String, paramType2:String):String {
			return cssClasses[paramType1 + "='" + paramType2 + "'"];
		}
		
		public function addLink(paramType1:String, paramType2:String, link:String):void {
			links[paramType1 + "='" + paramType2 + "'"] = link;
		}
		
		public function getLink(paramType1:String, paramType2:String):String {
			return links[paramType1 + "='" + paramType2 + "'"];
		}
		
		public function addContent(paramType1:String, paramType2:String, content:String):void {
			contents[paramType1 + "='" + paramType2 + "'"] = content;
		}
		
		public function getContent(paramType1:String, paramType2:String):String {
			return contents[paramType1 + "='" + paramType2 + "'"];
		}
	}

}