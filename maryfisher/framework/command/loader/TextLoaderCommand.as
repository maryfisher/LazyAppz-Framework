package maryfisher.framework.command.loader {
	import flash.events.Event;
	import flash.net.URLLoaderDataFormat;
	import maryfisher.framework.config.LoaderConfig;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TextLoaderCommand extends BaseURLLoaderCommand {
		
		public function TextLoaderCommand(callback:ITextLoadingCallback, id:String, fileId:String, priority:int=LoaderConfig.WHENEVER_PRIORITY, executeInstantly:Boolean = true) {
			
			_finishedLoading = new Signal(TextLoaderCommand);
			_finishedLoading.addOnce(callback.textLoadingFinished);
			_dataFormat = URLLoaderDataFormat.TEXT;
			super(id, fileId, priority, executeInstantly);
		}
		
	}

}