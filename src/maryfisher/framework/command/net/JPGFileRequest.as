package maryfisher.framework.command.net {
	import com.adobe.images.JPGEncoder;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import maryfisher.framework.data.NetData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class JPGFileRequest extends FileRequest {
		
		public function JPGFileRequest() {
			super();
			
		}
		
		override public function execute(requestData:Object, netData:NetData, requestSpecs:String):void {
			var bytes:ByteArray = new JPGEncoder(75).encode(requestData as BitmapData);
			writeBytes(requestSpecs, bytes);
		}
	}

}