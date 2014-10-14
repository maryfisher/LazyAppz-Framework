package maryfisher.framework.command.net {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import maryfisher.framework.data.NetData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class XMLRequest extends BaseURLRequest {
		
		public function XMLRequest() {
			
		}
		
		override public function execute(requestData:Object, netData:NetData, requestSpecs:String):void {
			super.execute(requestData, netData, requestSpecs);
			
			//var _url:String = netData.id;
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, onRequestComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onRequestError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			var request:URLRequest = new URLRequest(_baseUrl + _url + requestSpecs + ".xml");
			request.method = URLRequestMethod.POST;
			trace("[XMLRequest] execute load:", _baseUrl + _url + requestSpecs + ".xml");
			loader.load(request);
		}
		
		override protected function onRequestComplete(e:Event):void {
			var loader:URLLoader = URLLoader(e.target);
			loader.removeEventListener(Event.COMPLETE, onRequestComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onRequestError);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			var data:XML = XML(loader.data);
			if (data) {
				finishRequest(data);
			}
		}
	}

}