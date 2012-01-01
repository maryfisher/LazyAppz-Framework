package maryfisher.framework.view {
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IViewComponent{
		function get componentType():String;
		function destroy():void;
	}
	
}