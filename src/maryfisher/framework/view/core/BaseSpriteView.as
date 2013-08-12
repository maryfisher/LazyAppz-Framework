package maryfisher.framework.view.core {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.core.IKeyListener;
	import maryfisher.framework.event.ViewEvent;
	import maryfisher.framework.view.IViewComponent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSpriteView extends Sprite implements IViewComponent {
		
		public function BaseSpriteView() {
			super();
			
		}
		
		protected function dispatchFinishedLoading():void {
			dispatchEvent(new ViewEvent(ViewEvent.ON_FINISHED));
		}
		
		public function addOnFinished(listener:Function):void {
			listener(null);
			//addEventListener(ViewEvent.ON_FINISHED, listener);
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function destroy():void {
			
		}
		
		public function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			addEventListener(type, listener, useCapture, priority, useWeakReference);
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
			dispatchEvent(e);
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function removeListener(type:String, listener:Function, useCapture:Boolean = false):void {
			removeEventListener(type, listener, useCapture);
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function addViewComponent(comp:IViewComponent):void {
			addChild(comp as DisplayObject);
		}
		
		public function removeViewComponent(comp:IViewComponent):void {
			removeChild(comp as DisplayObject);
		}
		
		public function get componentType():String {
			throw new Error("Override this method to set the correct componentType");
			return "";
		}
		
		
	}

}