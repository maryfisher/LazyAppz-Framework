package maryfisher.framework.command.loader {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import maryfisher.framework.config.LoaderConfig;
	import maryfisher.framework.data.LoaderData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseURLLoaderCommand extends LoaderCommand {
		
		private var _data:*;
		private var _fileId:String;
		protected var _dataFormat:String;
		
		public function BaseURLLoaderCommand(id:String, fileId:String, priority:int=LoaderConfig.WHENEVER_PRIORITY) {
			_fileId = fileId;
			super(id, priority);
			
		}
		
		public override function loadAsset(loaderData:LoaderData):void {
			super.loadAsset(loaderData);
			
			
			var urlLoader : URLLoader = new URLLoader();
			urlLoader.dataFormat = _dataFormat;
			urlLoader.addEventListener(Event.COMPLETE, onLoaderComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
			urlLoader.load(new URLRequest(loaderData.path + _fileId));
		}
		
		private function onLoaderError(e:IOErrorEvent):void {
			trace(e.text);
		}
		
		protected function onLoaderComplete(e:Event):void {
			var urlLoader : URLLoader = URLLoader(e.currentTarget);
			_data = urlLoader.data;
			setFinished();
		}
		
		public function get data():* {
			return _data;
		}
		
		override public function get asset():Object {
			return _data as Object;
		}
		
		public override function set asset(value:Object):void {
			_data = value;
		}
	}

}