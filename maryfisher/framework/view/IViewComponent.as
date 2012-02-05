package maryfisher.framework.view {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IViewComponent{
		function get componentType():String;
		function destroy():void;
		//function addComponent(comp:IViewComponent):void;
	}
	
}