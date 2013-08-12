package maryfisher.framework.view.core {
	import away3d.containers.ObjectContainer3D;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.view.IViewComponent;
	import maryfisher.framework.view.IViewComponentContainer;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseContainer3DView extends ObjectContainer3D implements IViewComponentContainer{
		
		public function BaseContainer3DView(){
			
		}
		
		public function setPosition(scenePosition:Vector3D):void {
			position = scenePosition;
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function get componentType():String {
			return "";
		}
		
		public function destroy():void {
			removeView();
			dispose();
		}
		
		public function addOnFinished(listener:Function):void {
			listener(null);
		}
		
		public function dispatch(e:Event):void {
			dispatchEvent(e);
		}
		
		public function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeListener(type:String, listener:Function, useCapture:Boolean = false):void {
			removeEventListener(type, listener, useCapture);
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
		
		/* INTERFACE maryfisher.framework.view.IViewComponentContainer */
		
		public function addViewComponent(comp:IViewComponent):void {
			addChild(comp as ObjectContainer3D);
		}
		
		public function removeViewComponent(comp:IViewComponent):void {
			removeChild(comp as ObjectContainer3D);
		}
		
	}

}