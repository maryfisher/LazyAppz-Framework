package maryfisher.framework.data {
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LocaleComboData {
		
		protected var _localeDatas:Dictionary; /* of LocaleDatas */;
		public var language:String;
		
		public function LocaleComboData(lang:String) {
			language = lang;
			_localeDatas = new Dictionary();
		}
		
		public function addLocaleData(ld:LocaleData):void {
			_localeDatas[ld.id] = ld;
		}
		
		public function getText(id:String):LocaleText {
			var textByLang:LocaleText = (_localeDatas[id] as LocaleData).getTextByLang(language);
			if (!textByLang) textByLang = new LocaleText("");
			return textByLang;
		}
		
	}

}