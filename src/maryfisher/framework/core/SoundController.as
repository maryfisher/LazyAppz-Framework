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
		
		public function SoundController() {
		}
		
		static public function init(transforms:Vector.<String>):void {
			
			getInstance()._transforms = new Dictionary();
			for each (var item:String in transforms) {
				_instance._transforms[item] = new SoundTransform();
			}
		}
		
		static public function registerSound(sound:ISound):void {
			var s:SoundTransform = getInstance()._transforms[sound.soundType];
			if (!s) throw Error("No SoundTransform with that id");
			sound.soundTransform = s;
		}
		
		static public function registerSoundCommand(sound:SoundCommand):void {
			var s:SoundTransform = _instance._transforms[sound.transformId];
			if (!s) throw Error("No SoundTransform with that id");
			//if (!s) {
				//s = new SoundTransform();
				//_instance._transforms[sound.transformId] = s;
			//}
			s.volume = sound.volume;
		}
		
		static private function getInstance():SoundController {
			if(!_instance) {
				_instance = new SoundController();
			}
			
			return _instance;
		}
		
	}

}