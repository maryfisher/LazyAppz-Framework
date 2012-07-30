package maryfisher.framework.view {
	import flash.events.IEventDispatcher;
	
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IViewComponent extends IEventDispatcher{
		//function get viewComponent():*;
		function get componentType():String;
		function destroy():void;
		function addOnFinished(listener:Function):void;
		//function get finishedSignal():Signal;
		//function addComponent(comp:IViewComponent):void;
	}
	
}