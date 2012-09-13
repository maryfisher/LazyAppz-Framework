package maryfisher.framework.command.sound {
	import maryfisher.view.ui.interfaces.ISound;
	
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SoundCommand {
		
		public static const SOUND_OFF:String = "soundOff";
		public static const SOUND_ON:String = "soundOn";
		static public const SET_VOLUME:String = "setVolume";
		
		public var soundType:String;
		public var volume:int;
		//public static const PLAY_SOUND:String = "playSound";
		
		public function SoundCommand(type:String, volume:int = 0) {
			this.volume = volume;
			soundType = type;
		}
		
	}

}