package maryfisher.framework.view {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IView2DComponent extends IViewComponent{
		function get position():Point;
		function set position(value:Point):void;
		function get rect():Rectangle;
		function get width():Number;
		function get height():Number;
		function get updateSignal():Signal;
	}
	
}