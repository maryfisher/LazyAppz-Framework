package maryfisher.framework.event {
	import org.osflash.signals.events.GenericEvent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ChildEvent extends GenericEvent {
		
		private var _eventId:String;
		
		public function ChildEvent(eventId:String) {
			super(true);
			_eventId = eventId;
			
		}
		
		public function get eventId():String {
			return _eventId;
		}
		
	}

}