package maryfisher.framework.core {
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	import maryfisher.framework.command.sound.SoundCommand;
	import maryfisher.framework.sound.ISound;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SoundController {
		
		static private var _instance:SoundController;
		private var _transforms:Dictionary; /* of SoundTransform; */
		//private var _channels:Dictionary;
		private var _sounds:Dictionary;
		
		public function SoundController() {
		}
		
		static public function init(transforms:Vector.<String>):void {
			
			getInstance()._transforms = new Dictionary();
			//getInstance()._channels = new Dictionary();
			getInstance()._sounds = new Dictionary();
			for each (var item:String in transforms) {
				_instance._transforms[item] = new SoundTransform();
				//_instance._channels[item] = new Vector.<SoundChannel>();
				_instance._sounds[item] = new Vector.<ISound>();
			}
		}
		
		//static public function registerSound(sound:ISound):void {
		//var s:SoundTransform = getInstance()._transforms[sound.soundType];
		//if (!s) throw Error("No SoundTransform with that id");
		//sound.soundTransform = s;
		//}
		
		static public function registerSoundCommand(cmd:SoundCommand):void {
			
			var s:SoundTransform = _instance._transforms[cmd.transformId];
			//var c:Vector.<SoundChannel> = _instance._channels[cmd.transformId];
			var c:Vector.<ISound> = _instance._sounds[cmd.transformId];
			if (!s)
				throw Error("No SoundTransform with that id");
			
			switch (cmd.commandType) {
				case SoundCommand.SET_VOLUME: 
					//trace("set volume", cmd.transformId);
					s.volume = cmd.volume;
					//for each (var channel:SoundChannel in c) {
						//channel.soundTransform = s;
					//}
					for each (var sound:ISound in c) {
						sound.channelTransform = s;
					}
					break;
				case SoundCommand.REGISTER_CHANNEL: 
					//c.push(cmd.channel);
					//cmd.channel.soundTransform = s;
					c.push(cmd.sound);
					cmd.sound.channelTransform = s;
					break;
				case SoundCommand.UNREGISTER_CHANNEL: 
					c.splice(c.indexOf(cmd.sound), 1);
					break;
				case SoundCommand.GET_SOUNDTRANSFORM: 
					cmd.sound.soundTransform = s;
					break;
				default: 
			}
			//if (!s) {
			//s = new SoundTransform();
			//_instance._transforms[sound.transformId] = s;
			//}
		
		}
		
		static private function getInstance():SoundController {
			if (!_instance) {
				_instance = new SoundController();
			}
			
			return _instance;
		}
	
	}

}