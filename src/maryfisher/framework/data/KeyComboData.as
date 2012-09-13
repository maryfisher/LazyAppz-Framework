package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class KeyComboData {
		
		public var id:String;
		public var keys:Vector.<int>;
		
		public function KeyComboData(keys:Array, id:String) {
			this.id = id;
			this.keys = Vector.<int>(keys);
		}
		
	}

}