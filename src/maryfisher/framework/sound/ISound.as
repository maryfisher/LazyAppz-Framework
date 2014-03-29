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
		function set channelTransform(value:SoundTransform):void;
		function set fadeIn(value:Boolean):void;
		function set fadeOut(value:Boolean):void;
		
		//function get soundType():String;
	}
	
}