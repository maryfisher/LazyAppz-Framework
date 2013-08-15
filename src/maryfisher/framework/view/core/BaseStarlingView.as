package maryfisher.framework.view.core {
	import flash.events.Event;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.event.ViewEvent;
	import maryfisher.framework.view.IStarlingView;
	import maryfisher.framework.view.IViewComponent;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseStarlingView extends starling.display.Sprite implements IViewComponent, IStarlingView {
		
		private var _dispatcher:flash.display.Sprite;
		
		public function BaseStarlingView() {
			
		}
		
		protected function dispatchFinishedLoading():void {
			_dispatcher.dispatchEvent(new ViewEvent(ViewEvent.ON_FINISHED));
		}
		
		public function addOnFinished(listener:Function):void {
			listener(null);
		}
		
		public function destroy():void {
			
		}
		
		public function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function addView():void {
			new ViewCommand(this);
		}
		
		public function removeView():void {
			new ViewCommand(this, ViewCommand.REMOVE_VIEW);
		}
		
		public function pause():void {
			
		}
		
		public function show():void {
			visible = true;
		}
		
		public function hide():void {
			visible = false;
		}
		
		public function dispatch(e:Event):void {
			_dispatcher.dispatchEvent(e);
		}
		
		public function removeListener(type:String, listener:Function, useCapture:Boolean = false):void {
			_dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function addViewComponent(comp:IViewComponent):void {
			addChild(comp as DisplayObject);
		}
		
		public function removeViewComponent(comp:IViewComponent):void {
			removeChild(comp as DisplayObject);
		}
		
		public function unpause():void {
			
		}
		
		/* INTERFACE maryfisher.framework.view.IStarlingView */
		
		public function init():void {
			
		}
		
		public function get componentType():String {
			throw new Error("Override this method to set the correct componentType");
			return "";
		}
		
	}

}