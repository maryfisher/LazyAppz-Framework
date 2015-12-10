package maryfisher.framework.sound {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ISoundPlayer extends ISound{
		function play():void;
		function stop():void;
		function set fadeIn(value:Boolean):void;
		function set fadeOut(value:Boolean):void;
	}
	
}