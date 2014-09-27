package maryfisher.framework.command.sound {
	import maryfisher.framework.core.SoundController;
	import maryfisher.framework.sound.ISound;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SoundCommand {
		
		public static const SOUND_OFF:String = "soundOff";
		public static const SOUND_ON:String = "soundOn";
		static public const SET_VOLUME:String = "setVolume";
		static public const NEW_SOUNDTRANSFORM:String = "newSoundtransform";
		static public const REGISTER_CHANNEL:String = "registerChannel";
		static public const UNREGISTER_CHANNEL:String = "unregisterChannel";
		static public const GET_SOUNDTRANSFORM:String = "getSoundtransform";
		
		public var transformId:String;
		public var commandType:String;
		//public var channel:SoundChannel;
		public var volume:Number;
		public var sound:ISound;
		
		//public static const PLAY_SOUND:String = "playSound";
		
		//public function SoundCommand(type:String, transformId:String = "", volume:Number = 0, channel:SoundChannel = null, sound:ISound = null) {
		public function SoundCommand(type:String, transformId:String = "", volume:Number = 0, sound:ISound = null) {
			this.sound = sound;
			//this.channel = channel;
			this.transformId = transformId;
			this.volume = volume;
			commandType = type;
			execute();
		}
		
		public function execute():void {
			SoundController.registerSoundCommand(this);
		}
	}

}