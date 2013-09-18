package maryfisher.framework.model {
	import flash.utils.Dictionary;
	/**
	 *
	 * @author mary_fisher
	 */
	public class BaseModelUpdate {
		
		private var _updateId:String;
		
		public function BaseModelUpdate(updateId:String) {
			_updateId = updateId;
			
		}
		
		public function get updateId():String { return _updateId; }
		
	}

}