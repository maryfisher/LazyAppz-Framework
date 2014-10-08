package maryfisher.framework.command.net {
	import com.adobe.serialization.json.JSON;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import maryfisher.framework.data.NetData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class JSONRequest extends BaseURLRequest {
		
		public function JSONRequest() {
		}
		
		override public function execute(requestData:Object, netData:NetData, requestSpecs:String):void {
			if(requestData is IJSONData){
				requestData = (requestData as IJSONData).jsonObject;
			}
			
			super.execute(requestData, netData, requestSpecs);
			
			var json:String = com.adobe.serialization.json.JSON.encode(requestData);
			var _loader:URLLoader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, onRequestComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onRequestError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			var request:URLRequest = new URLRequest(_baseUrl + _url + requestSpecs);
			request.method = URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			variables.json = json;
			request.data = variables;
			
			_loader.load(request);
		}
		
		protected function adjustJSONDataObject(requestData:Object):Object {
			return requestData;
		}
		
		override protected function onRequestComplete(e:Event):void {
			var loader:URLLoader = URLLoader(e.target);
			trace("[JSONRequest] onRequestComplete ", loader.data);
			var data:Object = com.adobe.serialization.json.JSON.decode(loader.data);
			if (data) {
				finishRequest(adjustJSONDataObject(data));
			}
		}
		
		override public function get requestType():String {
			return TYPE_JSON;
		}
		
		//public function get url():String {
			//return _url;
		//}
	}

}