package maryfisher.framework.event {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ButtonEvent extends Event {
		
		static public const BUTTON_CLICKED:String = "buttonClicked";
		
		private var _buttonId:String;
		
		public function ButtonEvent(type:String, buttonId:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_buttonId = buttonId;
			
		}
		
		public function get buttonId():String {
			return _buttonId;
		}
		
	}

}