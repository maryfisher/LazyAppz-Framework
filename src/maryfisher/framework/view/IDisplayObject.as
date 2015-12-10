package maryfisher.framework.view {
	import flash.display.Stage;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IDisplayObject {
		function get width():Number;
		function get height():Number;
		function get x():Number;
		function get y():Number;
		function set x(value:Number):void;
		function set y(value:Number):void;
		function set visible(value:Boolean):void;
		function get visible():Boolean;
		function set alpha(value:Number):void;
		function set clipRect(value:Rectangle):void;
		//function set filters(value:Array):void;
		/** TODO
		 * addStageListener to make it independent from flash.display.Stage
		 */
		//function get stage():Stage;
		
	}
	
}