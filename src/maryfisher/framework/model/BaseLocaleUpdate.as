package maryfisher.framework.model {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseLocaleUpdate extends BaseModelUpdate {
		
		public var language:String;
		
		public function BaseLocaleUpdate(updateId:String, language:String) {
			super(updateId);
			this.language = language;
			
		}
		
	}

}