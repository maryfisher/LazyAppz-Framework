package maryfisher.framework.event {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ViewEvent extends Event {
		
		static public const ON_FINISHED:String = "ViewEvent/onFinished";
		
		public function ViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event { 
			return new ViewEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("ViewEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}