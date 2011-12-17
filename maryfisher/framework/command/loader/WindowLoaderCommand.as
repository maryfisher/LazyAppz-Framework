package maryfisher.framework.command.loader {
	
	import config.LoaderConfig;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getQualifiedClassName;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class WindowLoaderCommand extends LoaderCommand{
		
		protected var _assetDomain:ApplicationDomain;
		protected var _loader:Loader;
		protected var _asset:Sprite;
		
		public function WindowLoaderCommand(callback:ILoadingCallback, assetPath:String) {
			super('', assetPath, callback, '', true);
		}
		
		override public function loadAsset():void {
			
			_assetDomain = new ApplicationDomain();
			_loader = new Loader();
			var context:LoaderContext = new LoaderContext(false, _assetDomain);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onAssetLoaded, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError, false, 0, true);
			//_loader.load(new URLRequest(LoaderConfig.SWF_PATH + assetPath + ".swf"), null);
			//_loader.load(new URLRequest("../asset/ui/window/" + assetPath + "/bin/" + assetPath + ".swf"), null);
			//_loader.load(new URLRequest(LoaderConfig.SWF_PATH + "window/" + assetPath + "/bin/" + assetPath + ".swf"), context);
			_loader.load(new URLRequest(LoaderConfig.SWF_PATH + "window/" + _assetPath + "/bin/" + _assetPath + ".swf"));
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadingProgress, false, 0, true);
		}
		
		protected function onLoadingProgress(ev:ProgressEvent):void {
			setProgress(ev.bytesLoaded / ev.bytesTotal);
		}
		
		protected function onError(e:IOErrorEvent):void {
			trace('shit: ' + e.text);
		}
		
		protected function onAssetLoaded(ev:Event):void {
			//_asset = (_loader.content as MovieClip).getChildAt(0) as Sprite;
			//trace(_loader.content, (_loader.content as Sprite).numChildren);
			_asset = _loader.content as Sprite;
			setFinished();
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onAssetLoaded, false);
			//_loader.unload();
		}
		
		public function get content():Sprite {
			return _asset; 
		}
		
		override public function get asset():Object {
			if (_asset) {
				
				var classname:String = getQualifiedClassName(_asset);
				var assetClass:Class = _loader.contentLoaderInfo.applicationDomain.getDefinition(classname) as Class;
				trace('WindowLoaderCommand get asset', classname, assetClass);
				return assetClass;
			}
			return null;
		}
		
		override public function set asset(value:Object):void {
			if (value is Class) {
				_asset = new value();
				setFinished();
			}
		}
	}
}