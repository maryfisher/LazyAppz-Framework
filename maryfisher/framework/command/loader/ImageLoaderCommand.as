package maryfisher.framework.command.loader {
	import maryfisher.framework.config.LoaderConfig;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ImageLoaderCommand extends LoaderCommand {
		
		public function ImageLoaderCommand(id:String, priority:int=LoaderConfig.WHENEVER_PRIORITY) {
			super(id, priority);
			
		}
		
	}

}