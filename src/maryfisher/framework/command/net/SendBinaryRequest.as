package maryfisher.framework.command.net {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	import maryfisher.framework.command.AbstractCommand;
	import maryfisher.framework.data.NetData;
	import com.adobe.serialization.json.JSON;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SendBinaryRequest extends NetRequest {
		
		private var _requestData:ByteArray;
		private var _loader:URLLoader;
		private var _urlAddon:String;
		
		public function SendBinaryRequest(id:String, urlAddon:String, data:ByteArray, callback:INetRequestCallback) {
			_urlAddon = urlAddon;
			_requestData = data;
			super(id, callback);
		}
		
		override public function sendRequest(netData:NetData):void {
			super.sendRequest(netData);
			
			var url:String = _netData.url//"backend/";
			var request:URLRequest;
			
			_loader = new URLLoader();
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
			_loader.addEventListener(Event.COMPLETE, onRequestComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onRequestError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			request = new URLRequest(url + _urlAddon);
			request.method = URLRequestMethod.POST;
			request.data = _requestData;
			
			_loader.load(request);
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void {
			
		}
		
		private function onRequestError(e:IOErrorEvent):void {
			trace(e.text);
		}
		
		private function onRequestComplete(e:Event):void {
			var loader:URLLoader = URLLoader(e.target);
			trace(loader.data);
			_resultData = com.adobe.serialization.json.JSON.decode(loader.data);
			finishRequest();
		}
	}

}