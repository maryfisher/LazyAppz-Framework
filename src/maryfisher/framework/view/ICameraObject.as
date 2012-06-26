package maryfisher.framework.view {
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ICameraObject {
		function set cameraTilt(value:Number):void;
		function set cameraPan(value:Number):void;
		function setCameraPosition(cameraPos:Vector3D, lookAtPos:Vector3D):void;
		//function onCameraMove(panAngle:Number, tiltAngle:Number):void;
	}
	
}