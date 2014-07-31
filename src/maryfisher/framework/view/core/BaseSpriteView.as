package maryfisher.framework.view.core {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.core.IKeyListener;
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.event.ViewEvent;
	import maryfisher.framework.view.IViewComponent;
	import maryfisher.view.ui.component.BaseSprite;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSpriteView extends BaseSprite implements IViewComponent {
		
		protected var _dispatchFinish:Boolean;
		
		public function BaseSpriteView(dispatchFinish:Boolean = true) {
			super();
			_dispatchFinish = dispatchFinish;
			
		}
		
		protected function dispatchFinishedLoading():void {
			_dispatchFinish = true;
			dispatchEvent(new ViewEvent(ViewEvent.ON_FINISHED));
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		//public function addOnFinished(listener:Function):void {
			//listener(null);
			//addEventListener(ViewEvent.ON_FINISHED, listener);
		//}
		
		public function checkFinished():void {
			if(_dispatchFinish) dispatchFinishedLoading();
		}
		
		public function destroy():void {
			
		}
		
		//public function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			//addEventListener(type, listener, useCapture, priority, useWeakReference);
		//}
		
		public function addView():void {
			new ViewCommand(this);
		}
		
		public function removeView():void {
			new ViewCommand(this, ViewCommand.REMOVE_VIEW);
		}
		
		public function pause():void {
			
		}
		
		public function unpause():void {
			
		}
		
		public function show():void {
			visible = true;
		}
		
		public function hide():void {
			visible = false;
		}
		
		//public function dispatch(e:Event):void {
			//dispatchEvent(e);
		//}
		
		//public function removeListener(type:String, listener:Function, useCapture:Boolean = false):void {
			//removeEventListener(type, listener, useCapture);
		//}
		
		public function addViewComponent(comp:IViewComponent):void {
			addChild(comp as DisplayObject);
		}
		
		public function removeViewComponent(comp:IViewComponent):void {
			removeChild(comp as DisplayObject);
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function get zIndex():int {
			return ViewController.Z_NORMAL;
		}
		
		//public function hasListener(type:String):Boolean {
			//return hasEventListener(type);
		//}
		
		public function get componentType():String {
			throw new Error("Override this method to set the correct componentType");
			return "";
		}
		
		
	}

}