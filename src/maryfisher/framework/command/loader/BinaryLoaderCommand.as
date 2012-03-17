package maryfisher.framework.command.loader {
	import flash.events.Event;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.ByteArray;
	import maryfisher.framework.config.LoaderConfig;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BinaryLoaderCommand extends BaseURLLoaderCommand {
		
		public function BinaryLoaderCommand(callback:IBinaryLoadingCallback, id:String, fileId:String, priority:int=LoaderConfig.WHENEVER_PRIORITY, executeInstantly:Boolean = true) {
			
			_finishedLoading = new Signal(BinaryLoaderCommand);
			_finishedLoading.addOnce(callback.binaryLoadingFinished);
			_dataFormat = URLLoaderDataFormat.BINARY;
			
			super(id, fileId, priority, executeInstantly);
		}
		
		override public function get asset():Object {
			
			var tmp:ByteArray = new ByteArray();
			tmp.writeObject(_data as ByteArray);           
			tmp.position = 0;
			var b2:* = tmp.readObject();
			return b2;
		}
	}

}