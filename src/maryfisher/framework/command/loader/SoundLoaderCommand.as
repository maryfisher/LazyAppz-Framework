package maryfisher.framework.command.loader {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SoundLoaderCommand extends LoaderCommand {
		
		public function SoundLoaderCommand(id:String, fileId:String="", priority:int=0, executeInstantly:Boolean=true) {
			super(id, fileId, priority, executeInstantly);
			
		}
		
	}

}