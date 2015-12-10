package maryfisher.framework.data {
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LocaleText {
		
		private var _text:String;
		public var paramText:String;
		public var formattedText:String;
		public var formattedHTMLText:String;
		private var _parameters:Dictionary; //paramId => Vector.<LocaleTextParameter>
		private var _allParameters:Vector.<LocaleTextParameter>; //paramId => Vector.<LocaleTextParameter>
		
		public function LocaleText(text:String) {
			this.text = text || "";
		}
		
		public function getParams(param:String):Vector.<LocaleTextParameter> {
			return _parameters[param];
		}
		
		public function get escapedText():String {
			var escaped:String = text;
			escaped = escaped.split("'").join("\\\"");
			return escaped;
		}
		
		public function get text():String {
			return _text;
		}
		
		public function set text(value:String):void {
			_text = value;
			
			_text = _text.split("\\\"").join("'");
			_text = _text.split("\\\'").join('"');
			_text = _text.replace(/\\n/g, '\n');
			formattedText = _text;
			
			_parameters = new Dictionary();
			_allParameters = new Vector.<LocaleTextParameter>();
			var index:int = -1;
			var xml:XML = XML("<elm>" + formattedText + "</elm>");
			for each (var item:XML in xml.elements("*")) {
				var vec:Vector.<LocaleTextParameter> = _parameters[item.name()];
				if (!vec) {
					vec = new Vector.<LocaleTextParameter>();
					_parameters[item.name()] = vec;
				}
				var str:String = item.toXMLString();
				index = text.indexOf(str, index + 1);
				var ltp:LocaleTextParameter = new LocaleTextParameter(item.name(), item, formattedText.indexOf(str), index);
				vec.push(ltp);
				_allParameters.push(ltp);
				formattedText = formattedText.replace(str, item.toString());
			}
			
		}
		
		public function get allParameters():Vector.<LocaleTextParameter> {
			return _allParameters;
		}
		
		public function formatToHTML(paramMap:LocaleTextParamMap, paramId:String = "param", addLinks:Boolean = false):String {
			formattedHTMLText = formattedText;
			for (var i:int = _allParameters.length - 1; i >= 0; i--) {
				var ltp:LocaleTextParameter = _allParameters[i];
				if (ltp.id != paramId) continue;
				var startIndex:int = ltp.indexFormatted;
				var endIndex:int = ltp.indexFormatted + ltp.text.length;
				var paramType1:String = ltp.getAttributeNameByPos();
				var paramType2:String = ltp.getAttributeValByPos();
				var contentText:String;
				if (ltp.text.length > 0) {
					contentText = ltp.text;
				}else {
					contentText = paramMap.getContent(paramType1, paramType2);
				}
				
				var spanStr:String = '<span class="' + paramMap.getCssClass(paramType1, paramType2) + '">' + contentText + '</span>';
				if (addLinks) {
					spanStr ='<a href="event:' + paramMap.getLink(paramType1, paramType2) + '">' + spanStr + '</a>'
				}
				formattedHTMLText = formattedHTMLText.substring(0, startIndex) + spanStr + formattedHTMLText.substring(endIndex, formattedHTMLText.length)
			}
			
			return formattedHTMLText;
		}
		
		public function getShortened(length:int = 20):String {
			if (text.length <= length + 3) {
				return text;
			}
			return text.substr(0, length) + "...";
		}
		
		public function clone():LocaleText {
			return new LocaleText(text);
		}
	}

}