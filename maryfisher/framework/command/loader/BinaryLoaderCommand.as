package maryfisher.framework.command.loader {
	import flash.events.Event;
	import flash.net.URLLoaderDataFormat;
	import maryfisher.framework.config.LoaderConfig;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BinaryLoaderCommand extends BaseURLLoaderCommand {
		
		public function BinaryLoaderCommand(callback:IBinaryLoadingCallback, id:String, fileId:String, priority:int=LoaderConfig.WHENEVER_PRIORITY) {
			
			_finishedLoading = new Signal(BinaryLoaderCommand);
			_finishedLoading.addOnce(callback.binaryLoadingFinished);
			_dataFormat = URLLoaderDataFormat.BINARY;
			
			super(id, fileId, priority);
		}
	}

}