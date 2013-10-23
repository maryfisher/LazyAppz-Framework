package maryfisher.framework.model {
	
	import flash.utils.Dictionary;
	import maryfisher.framework.data.LocaleData;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseLocaleModel extends AbstractModel {
		
		//static public const ON_LANGUAGE_CHANGED:String = "onLanguageChanged";
		
		/** TODO
		 * Enum
		 */
		protected var _language:String;
		private var _texts:Dictionary; /* of LocaleData */
		
		public function BaseLocaleModel() {
			
		}
		
		public function addText(localeData:LocaleData):void {
			_texts || (_texts = new Dictionary());
			_texts[localeData.context + "_" + localeData.id] = localeData;
			
		}
		
		public function setTexts(texts:Vector.<LocaleData>):void {
			_texts || (_texts = new Dictionary());
			for each (var localeData:LocaleData in texts) {
				_texts[localeData.context + "_" + localeData.id] = localeData;
			}
		}
		
		public function getText(context:String, id:String):LocaleData {
			var ld:LocaleData = _texts[context + "_" + id];
			if (!ld) ld = new LocaleData("");
			ld.language = _language;
			return ld;
		}
		
		public function set language(value:String):void {
			if (_language == value) return;
			_language = value;
			//dispatch(new BaseLocaleUpdate(ON_LANGUAGE_CHANGED, _language));
		}
		
	}

}