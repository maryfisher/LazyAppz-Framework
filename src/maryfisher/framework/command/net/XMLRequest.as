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
	public class XMLRequest extends NetRequest {
		
		public function XMLRequest() {
			
		}
		
		override public function execute(requestData:Object, netData:NetData, requestSpecs:String):void {
			super.execute(requestData, netData, requestSpecs);
			
			var _loader:URLLoader = new URLLoader();
			_loader.dataFormat = URLLoaderDataFormat.TEXT;
			_loader.addEventListener(Event.COMPLETE, onRequestComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onRequestError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			var request:URLRequest = new URLRequest(_baseUrl + _url + requestSpecs);
			request.method = URLRequestMethod.POST;
			
			_loader.load(request);
		}
		
		override protected function onRequestComplete(e:Event):void {
			var loader:URLLoader = URLLoader(e.target);
			var data:XML = XML(loader.data);
			if (data) {
				finishRequest(data);
			}
		}
		
		override public function get requestType():String {
			return TYPE_XML;
		}
	}

}