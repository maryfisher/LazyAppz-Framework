package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LocaleText {
		
		public var text:String;
		public var paramText:String;
		public var formattedText:String;
		//private var _parameters;
		
		public function LocaleText(text:String) {
			this.text = text || "";
			this.text = this.text.split("\\\"").join("'");
			this.text = this.text.split("\\\'").join('"');
			this.text = this.text.replace(/\\n/g, '\n');
			formattedText = text;
		}
		
		public function get escapedText():String {
			var escaped:String = text;
			escaped = escaped.split("'").join("\\\"");
			return escaped;
		}
		
		public function getShortened(length:int = 20):String {
			if (text.length <= length + 3) {
				return text;
			}
			return text.substr(0, length) + "...";
		}
		
		public function getParameters():void {
			
		}
		
		public function clone():LocaleText {
			return new LocaleText(text);
		}
	}

}