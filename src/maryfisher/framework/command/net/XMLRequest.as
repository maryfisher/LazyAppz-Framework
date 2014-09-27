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
		private var _baseUrl:String;
		
		public function XMLRequest() {
			
		}
		
		override public function execute(requestData:Object, netData:NetData, requestSpecs:String):void {
			super.execute(requestData, netData, requestSpecs);
			
			var _url:String = netData.id;
			var _loader:URLLoader = new URLLoader();
			_loader.dataFormat = URLLoaderDataFormat.TEXT;
			_loader.addEventListener(Event.COMPLETE, onRequestComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onRequestError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			var request:URLRequest = new URLRequest(_baseUrl + _url + requestSpecs);
			request.method = URLRequestMethod.POST;
			
			_loader.load(request);
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void {
			
		}
		
		private function onRequestError(e:IOErrorEvent):void {
			
		}
		
		protected function onRequestComplete(e:Event):void {
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