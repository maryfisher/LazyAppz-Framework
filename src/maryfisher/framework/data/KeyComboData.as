package maryfisher.framework.data {
	import maryfisher.framework.core.IKeyListener;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class KeyComboData {
		public var listener:IKeyListener;
		
		public var id:String;
		public var keys:Vector.<int>;
		
		public function KeyComboData(keys:Array, id:String, listener:IKeyListener) {
			this.listener = listener;
			this.id = id;
			this.keys = Vector.<int>(keys);
		}
		
	}

}