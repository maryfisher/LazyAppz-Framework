package maryfisher.framework.command.net {
	import com.adobe.images.JPGEncoder;
	import flash.display.BitmapData;
	import flash.net.URLLoader;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SendJPGRequest extends SendBinaryRequest {
		
		public function SendJPGRequest(id:String, urlAddon:String, data:BitmapData, callback:INetRequestCallback) {
			var bytes:ByteArray = new JPGEncoder(75).encode(data);
			super(id, urlAddon, bytes, callback);
		}
		
	}

}