package maryfisher.framework.command.loader {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import maryfisher.framework.data.LoaderData;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class XMLLoaderCommand extends LoaderCommand{
		
		private var _xml:XML;
		
		public function XMLLoaderCommand(id:String, fileId:String, callback:IXMLLoadingCallback, executeInstantly:Boolean = true) {
			_finishedLoading = new Signal(LoaderCommand);
			_finishedLoading.addOnce(callback.loadingXMLFinished);
			super(id, fileId, 0, executeInstantly);
			
			
		}
		
		override public function loadAsset(loaderData:LoaderData):void {
			super.loadAsset(loaderData);
			var urlRequest:URLRequest = new URLRequest(_loaderData.path + _fileId + '.xml');
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
		
		override public function get asset():Object {
			return _xml;
		}
		
		override public function set asset(value:Object):void {
			_xml = XML(value);
			//setFinished();
		}
	}

}