package maryfisher.framework.core {
	import flash.media.SoundTransform;
	import maryfisher.framework.command.sound.SoundCommand;
	import maryfisher.view.ui.interfaces.ISound;
	import maryfisher.view.ui.sound.BaseSound;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SoundController {
		
		static private var _instance:SoundController;
		private var _transform:SoundTransform;
		
		public function SoundController() {
			_transform = new SoundTransform();
		}
		
		static public function registerSound(sound:ISound):void {
			sound.soundTransform = getInstance()._transform;
		}
		
		static public function registerSoundCommand(sound:SoundCommand):void {
			
		}
		
		static private function getInstance():SoundController {
			(!_instance) {
				_instance = new SoundController();
			}
			
			return _instance;
		}
		
	}

}