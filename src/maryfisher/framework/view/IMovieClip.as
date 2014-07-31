package maryfisher.framework.view {
	
	/**
	 * extends IDisplayObject?
	 * @author mary_fisher
	 */
	public interface IMovieClip extends IDisplayObject{
		function play(frameId:String = null, loop:Boolean = false):void;
		function stop():void;
		function addOnFinished(onClipFinished:Function):void;
	}
	
}