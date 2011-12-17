package maryfisher.framework.view {
	import flash.geom.Point;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IViewComponent {
		function get componentType():String;
		function get position():Point;
		function set position(value:Point):void;
		//function get updateSignal():Signal
	}
	
}