package maryfisher.framework.core {
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	import maryfisher.framework.command.sound.SoundCommand;
	import maryfisher.view.ui.interfaces.ISound;
	import maryfisher.view.ui.sound.BaseSound;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SoundController {
		
		static private var _instance:SoundController;
		private var _transforms:Dictionary; /* of SoundTransform; */
		
		public function SoundController() {
			_transforms = new Dictionary();
		}
		
		static public function registerSound(sound:ISound):void {
			
			sound.soundTransform = getInstance()._transforms[sound.soundType];
		}
		
		static public function registerSoundCommand(sound:SoundCommand):void {
			var s:SoundTransform = _instance._transforms[sound.transformId];
			if (!s) {
				s = new SoundTransform();
				_instance._transforms[sound.transformId] = s;
			}
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