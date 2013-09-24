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
		function addOnFinished(listener:Function):void;
		//onFinishedLoading
		function dispatch(e:Event):void;
		function hasListener(type:String):Boolean
		function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
		function removeListener(type:String, listener:Function, useCapture:Boolean=false) : void
		function addView():void;
		function removeView():void;
		function pause():void;
		function unpause():void;
		function show():void;
		function hide():void;
		function addViewComponent(comp:IViewComponent):void;
		function removeViewComponent(comp:IViewComponent):void;
	}
	
}