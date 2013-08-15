package maryfisher.framework.sound {
	import flash.media.SoundTransform;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ISound {
		function play():void;
		function stop():void;
		function set soundTransform(value:SoundTransform):void;
		function fadeIn():void;
		function fadeOut():void;
		
		function get soundType():String;
	}
	
}