package maryfisher.framework.view.core {
	import flash.display.DisplayObject;
	import maryfisher.framework.command.view.ViewCommand;
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
		
		public function checkFinished():void {
			if(_dispatchFinish) dispatchFinishedLoading();
		}
		
		public function destroy():void {
			
		}
		
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
		
		public function addViewComponent(comp:IViewComponent):void {
			addChild(comp as DisplayObject);
		}
		
		public function removeViewComponent(comp:IViewComponent):void {
			removeChild(comp as DisplayObject);
		}
		
		public function get zIndex():int {
			return ViewController.Z_NORMAL;
		}
		
		public function get componentType():String {
			throw new Error("Override this method to set the correct componentType");
			return "";
		}
	}
}