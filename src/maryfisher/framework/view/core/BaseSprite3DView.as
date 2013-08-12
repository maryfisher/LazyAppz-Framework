package maryfisher.framework.view.core {
	import away3d.entities.Sprite3D;
	import away3d.materials.MaterialBase;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.view.IViewComponent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSprite3DView extends Sprite3D implements IViewComponent {
		
		public function BaseSprite3DView(material:MaterialBase, width:Number, height:Number) {
			super(material, width, height);
			
		}
		
		public function setPosition(scenePosition:Vector3D):void {
			position = scenePosition;
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function get componentType():String {
			return "";
		}
		
		public function destroy():void {
			
		}
		
		public function addOnFinished(listener:Function):void {
			
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
		
	}

}