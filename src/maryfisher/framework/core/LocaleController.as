package maryfisher.framework.core {
	import flash.utils.Dictionary;
	import maryfisher.framework.data.LocaleContextData;
	import maryfisher.framework.data.LocaleData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LocaleController {
		
		static public var language:String;
		static private var _texts:Dictionary; /* of LocaleData */
		
		public function LocaleController() {
			
		}
		
		static public function setTexts(texts:Array):void {
			_texts = new Dictionary();
			for each (var item:Object in texts) {
				var localeData:LocaleData = new LocaleData(item);
				_texts[localeData.context + "_" + localeData.id] = localeData;
			}
		}
		
		static public function getText(contextData:LocaleContextData):LocaleData {
			var ld:LocaleData = _texts[contextData.contextId];
			if (!ld) ld = new LocaleData("");
			ld.language = language;
			return ld;
		}
	}

}