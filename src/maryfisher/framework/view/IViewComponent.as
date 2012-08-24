package maryfisher.framework.view {
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IViewComponent{
		//function get viewComponent():*;
		function get componentType():String;
		function destroy():void;
		//function addOnFinished(listener:Function):void;
		function dispatch(e:Event):void;
		function addListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false) : void
		function addView():void;
		function removeView():void;
		function pause():void;
		function show():void;
		function hide():void;
	}
	
}