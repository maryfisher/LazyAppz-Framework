package maryfisher.framework.command.net {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseURLRequest extends NetRequest {
		
		protected var _baseUrl:String;
		protected var _url:String;
		
		
		public function BaseURLRequest() {
			
		}
		
		protected function onRequestComplete(e:Event):void {
			
		}
		
		protected function onSecurityError(e:SecurityErrorEvent):void {
			trace(e.text);
		}
		
		protected function onRequestError(e:IOErrorEvent):void {
			trace(e.text);
		}
		
		public function set baseUrl(value:String):void {
			_baseUrl = value;
		}
		
		public function set url(value:String):void {
			_url = value;
		}
		
	}

}