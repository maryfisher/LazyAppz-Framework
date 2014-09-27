package maryfisher.framework.view.core {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import maryfisher.framework.view.IDisplayObject;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSprite extends Sprite implements IDisplayObject {
		
		public function BaseSprite() {
			
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IDisplayObject */
		
		public function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeListener(type:String, listener:Function, useCapture:Boolean = false):void {
			removeEventListener(type, listener, useCapture);
		}
		
		public function hasListener(type:String):Boolean {
			return hasEventListener(type);
		}
		
		public function dispatch(e:Event):void {
			dispatchEvent(e);
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IDisplayObjectContainer */
		
		public function addDisplayChild(child:IDisplayObject):void {
			addChild(child as DisplayObject);
		}
		
		public function removeDisplayChild(child:IDisplayObject):void {
			removeChild(child as DisplayObject);
		}
		
		public function set clipRect(value:Rectangle):void {
			mask = new Bitmap(new BitmapData(value.width, value.height, false, 0));
			mask.x = value.x;
			mask.y = value.y;
		}
		
	}

}