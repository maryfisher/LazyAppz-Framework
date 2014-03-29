package maryfisher.framework.view {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IEventListener {
		function hasListener(type:String):Boolean
		function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
		function removeListener(type:String, listener:Function, useCapture:Boolean=false) : void
		
	}
	
}