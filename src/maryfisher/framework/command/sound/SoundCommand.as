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
		static public const NEW_SOUNDTRANSFORM:String = "newSoundtransform";
		
		public var transformId:String;
		public var soundType:String;
		public var volume:Number;
		//public static const PLAY_SOUND:String = "playSound";
		
		public function SoundCommand(type:String, volume:Number = 0, transformId:String = "") {
			this.transformId = transformId;
			this.volume = volume;
			soundType = type;
		}
		
	}

}