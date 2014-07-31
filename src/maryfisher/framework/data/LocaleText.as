package maryfisher.framework.data {
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LocaleText {
		
		public var text:String;
		public var paramText:String;
		public var formattedText:String;
		private var _parameters:Dictionary; //elmId => XML
		
		public function LocaleText(text:String) {
			this.text = text || "";
			this.text = this.text.split("\\\"").join("'");
			this.text = this.text.split("\\\'").join('"');
			this.text = this.text.replace(/\\n/g, '\n');
			formattedText = text;
			
			_parameters = new Dictionary();
			var index:int = -1;
			//if (this.text.indexOf("<pause") != -1 || this.text.indexOf("<option") != -1) {
			//try {
				var xml:XML = XML("<elm>" + formattedText + "</elm>");
				for each (var item:XML in xml.elements("*")) {
					var vec:Vector.<LocaleTextParameter> = _parameters[item.name()];
					if (!vec) {
						vec = new Vector.<LocaleTextParameter>();
						_parameters[item.name()] = vec;
					}
					var str:String = item.toXMLString();
					index = text.indexOf(str, index + 1);
					vec.push(new LocaleTextParameter(item, formattedText.indexOf(str), index));
					formattedText = formattedText.replace(str, "");
				}
			//}catch (e:Error) {
				//trace("ERROR:", formattedText);
			//}
			
			//var index:int = -1;
			//var i:int;
			//for (var key:String in _parameters) {
				//vec = _parameters[key];
				//while ((index = this.text.indexOf("<" + key, index + 1)) != -1) {
					//var elm:XML = xml.elements(key)[i];
					//vec.push(new LocaleTextParameter(elm, index));
					//formattedText = formattedText.replace(elm.toXMLString(), "");
				//}
				//i++;
			//}
			
			//_breaks = new Vector.<int>();
			//while ((index = this.text.indexOf("<pause time=", index + 1)) != -1) {
				//formattedText = formattedText.replace(/<pause time=\"[0-9]*\.[0-9]\"\/\>/g, "");
				//_breaks.push(index);
			//}
			//index = -1;
			//while ((index = this.text.indexOf("<option", index + 1)) != -1) {
				//formattedText = formattedText.replace(/<option id=\"\"\>/g, "");
				//trace(formattedText);
			//}
		}
		
		public function getParams(param:String):Vector.<LocaleTextParameter> {
			return _parameters[param];
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