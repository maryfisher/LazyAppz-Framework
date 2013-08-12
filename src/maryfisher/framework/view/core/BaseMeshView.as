package maryfisher.framework.view.core {
	import away3d.core.base.Geometry;
	import away3d.entities.Entity;
	import away3d.entities.Mesh;
	import away3d.materials.MaterialBase;
	import flash.events.Event;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.view.IViewComponent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseMeshView extends Mesh implements IViewComponent {
		
		public function BaseMeshView(geometry:Geometry, material:MaterialBase=null) {
			super(geometry, material);
			
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function get componentType():String {
			return "";
		}
		
		public function destroy():void {
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
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function addViewComponent(comp:IViewComponent):void {
			addChild(comp as Entity);
		}
		
		public function removeViewComponent(comp:IViewComponent):void {
			removeChild(comp as Entity);
		}
		
	}

}