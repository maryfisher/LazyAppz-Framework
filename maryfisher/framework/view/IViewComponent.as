package maryfisher.framework.view {
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IViewComponent{
		function get componentType():String;
		function destroy():void;
		
		function get finishedSignal():Signal;
		//function addComponent(comp:IViewComponent):void;
	}
	
}