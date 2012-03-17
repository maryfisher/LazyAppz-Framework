package maryfisher.framework.command.loader {
	import avmplus.getQualifiedClassName;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	import maryfisher.framework.config.LoaderConfig;
	import maryfisher.framework.data.LoaderData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseURLLoaderCommand extends LoaderCommand {
		
		protected var _data:*;
		protected var _dataFormat:String;
		
		public function BaseURLLoaderCommand(id:String, fileId:String, 
					priority:int=LoaderConfig.WHENEVER_PRIORITY, executeInstantly:Boolean = true) {
			
			super(id, fileId, priority, executeInstantly);
			
		}
		
		public override function loadAsset(loaderData:LoaderData):void {
			super.loadAsset(loaderData);
			
			
			var _urlLoader : URLLoader = new URLLoader();
			_urlLoader.dataFormat = _dataFormat;
			_urlLoader.addEventListener(Event.COMPLETE, onLoaderComplete);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
			_urlLoader.load(new URLRequest(loaderData.path + _fileId));
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
			//if (_data) {
				//
				//var classname:String = getQualifiedClassName(_data);
				//var assetClass:Class = getDefinitionByName(classname) as Class;
				//
				//return assetClass;
			//}
			//return null;
		}
		
		public override function set asset(value:Object):void {
			_data = value;
			//if (value is Class) {
				//_data = new value();
			//}
		}
	}

}