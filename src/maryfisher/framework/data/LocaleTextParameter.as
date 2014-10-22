package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LocaleTextParameter {
		public var id:String;
		public var indexOrig:int;
		public var indexFormatted:int;
		private var _node:XML;
		public var text:String;
		
		public function LocaleTextParameter(id:String, content:XML, indexFormatted:int, indexOrig:int) {
			this.id = id;
			this.indexOrig = indexOrig;
			this.indexFormatted = indexFormatted;
			_node = content;
			text = content.toString();
			trace("[LocaleTextParameter]", getAttributeNameByPos());
			trace("[LocaleTextParameter]", getAttributeValByPos());
		}
		
		public function getAttribute(att:String):String {
			return _node["@" + att];
		}
		
		public function getAttributeNameByPos(pos:int = 0):String {
			if (_node.attributes().length() == 0) {
				return "";
			}
			return _node.attributes()[pos].name();
		}
		
		public function getAttributeValByPos(pos:int = 0):String {
			if (_node.attributes().length() == 0) {
				return "";
			}
			return _node.attributes()[pos].toString();
		}
		
		public function getAttributeByPos(pos:int = 0):String {
			if (_node.attributes().length() == 0) {
				return "";
			}
			return _node.attributes()[pos].toXMLString();
		}
	}

}