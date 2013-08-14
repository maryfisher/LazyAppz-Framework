package maryfisher.framework.view {
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import flash.display.Stage;
	import flash.geom.Vector3D;
	import maryfisher.framework.view.ICameraObject;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ICameraController {
		function addTiltListener(listener:Function):void;
		function addPanListener(listener:Function):void;
		//function tiltSignal():Signal;
		//function panSignal():Signal;
		function destroy():void;
		function start(stage:Stage = null):void;
		function stop():void;
		function assignBounds(minX:int, maxX:int, minY:int, maxY:int):void;
		function setMinMaxAngle(minTiltAngle:Number = 0, maxTiltAngle:Number = 90, minPanAngle:Number = NaN, maxPanAngle:Number = NaN):void;
		function setMinMaxPos(minPosX:Number, maxPosX:Number, minPosZ:Number, maxPosZ:Number):void;
		function moveLookAtObject(pos:Vector3D):void
		
		function registerCameraObject(co:ICameraObject):void;
		function unregisterCameraObject(co:ICameraObject):void;
	}
	
}