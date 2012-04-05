package maryfisher.framework.view {
	
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IViewComponent {
		//function get viewComponent():*;
		function get componentType():String;
		function destroy():void;
		function addOnFinished(listener:Function):void;
		//function get finishedSignal():Signal;
		//function addComponent(comp:IViewComponent):void;
	}
	
}