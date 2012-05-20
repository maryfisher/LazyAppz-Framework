package maryfisher.framework.command.net {
	import com.adobe.serialization.json.JSON;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import maryfisher.austengames.model.data.party.preparation.PartyGarmentVO;
	import maryfisher.framework.command.AbstractCommand;
	import maryfisher.framework.data.NetData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SendJSONRequest extends NetRequest {
		
		private var _requestData:Object;
		private var _loader:URLLoader;
		
		public function SendJSONRequest(id:String, data:Object, callback:INetRequestCallback) {
			_requestData = data;
			super(id, callback);
		}
		
		override public function sendRequest(netData:NetData):void {
			super.sendRequest(netData);
			var url:String = netData.url//"backend/";
			
			var json:String = com.adobe.serialization.json.JSON.encode(_requestData);
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, onRequestComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onRequestError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			variables.json = json;
			request.data = variables;
			
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
			var data:Object = com.adobe.serialization.json.JSON.decode(loader.data);
			if (data) {
				_resultData = data;
				finishRequest();
				//for (var i:String in data){
					//trace(i, data[i]);
					//if (data[i] is Object) {
						//var vo:PartyGarmentVO = new PartyGarmentVO();
						//vo.id = data[i]["garmentId"];
						//vo.selectedType = data[i]["selectedType"];
						//vo.color = parseInt(data[i]["color"]);
						//trace(vo);
						//for (var j:String in data[i]) {
							//
							//trace("second layer", j, data[i][j]);
						//}
					//}
				//}
			}
		}
	}

}