package maryfisher.framework.command.loader {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class XMLLoaderCommand extends LoaderCommand{
		
		private var _xml:XML;
		
		public function XMLLoaderCommand(path:String, id:String, callback:ILoadingCallback, description:String = '') {
			super(id, path, callback, description);
			
			
		}
		
		override public function loadAsset():void {
			
			var urlRequest:URLRequest = new URLRequest(_assetPath + '.xml');
			//if (xmldata != null) {				
				//urlRequest.data = xmldata;
				//urlRequest.contentType = "text/xml";
				//urlRequest.method = URLRequestMethod.POST;
			//}
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoadingFinished);
			loader.addEventListener(ProgressEvent.PROGRESS, onLoaderProgress);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			loader.load(urlRequest);
		}
		
		protected function onLoaderProgress(ev:ProgressEvent):void {
			setProgress(ev.bytesLoaded / ev.bytesTotal);
		}
		
		protected function onLoadingFinished(ev:Event):void {
			_xml = XML(ev.target.data);
			//trace('xml loaded ');
			setFinished();
		}
		
		public static function onIOError(ev:IOErrorEvent):void{
			trace("IOError:" + ev.text);
		}
		
		public static function onSecurityError(ev:SecurityErrorEvent):void{
			trace("Security:" + ev.text);
		}
		
		public function get xml():XML { return _xml; }
		
		//override public function set asset(value:Object):void {
			//if () {
				//
			//}
		//}
	}

}