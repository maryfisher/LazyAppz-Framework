package maryfisher.framework.command {
	import maryfisher.framework.command.loader.LoaderCommand;
	import maryfisher.framework.command.sound.ISoundLoadingCallback;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LoadSoundCommand extends LoaderCommand {
		
		public function LoadSoundCommand(id:String, callback:ISoundLoadingCallback, fileId:String = "", playSound:Boolean = false, executeInstantly:Boolean = true) {
			super(id, fileId, 0, executeInstantly);
		}
		
	}

}