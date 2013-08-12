package maryfisher.framework.data {
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LocaleData extends BaseData {
		
		public var id:String;
		public var context:String;
		public var language:String;
		private var _texts:Dictionary; /* language => LocaleText */
		
		public function LocaleData(data:*) {
			_texts = new Dictionary();
			super(data);
		}
		
		override protected function parseObject(data:Object):void {
			id = data.id;
			context = data.context;
			
			for (var key:String in data) {
				if (key != "id" || key != "context") {
					_texts[key] = new LocaleText(data[key]);
				}
			}
		}
		
		public function getText():LocaleText {
			return _texts[language] || new LocaleText("");
		}
	}

}