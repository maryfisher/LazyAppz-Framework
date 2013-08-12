package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LocaleContextData {
		
		private var _context:String;
		private var _id:String;
		
		public function LocaleContextData(context:String, id:String) {
			_context = context;
			_id = id;
			
		}
		
		public function get contextId():String {
			return _context + "_" + _id;
		}
	}

}