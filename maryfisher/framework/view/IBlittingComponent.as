package maryfisher.framework.view {
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IBlittingComponent extends IViewComponent{
		function get bounds():Rectangle;
		function get bitmapData():BitmapData;
		function get hitColor():uint
	}
	
}