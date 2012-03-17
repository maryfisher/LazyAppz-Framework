package maryfisher.framework.command.loader {
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import maryfisher.framework.data.LoaderData;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ClassLoaderCommand extends LoaderCommand {
		
		protected var _assetDomain:ApplicationDomain;
		protected var _loader:Loader;
		
		public function ClassLoaderCommand(id:String) {
			super(id);
		}
		
		override public function loadAsset(loaderData:LoaderData):void {
			super.loadAsset(loaderData);
			_assetDomain = new ApplicationDomain();
			_loader = new Loader();
			var context:LoaderContext = new LoaderContext(false, _assetDomain);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onAssetLoaded, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError, false, 0, true);
			_loader.load(new URLRequest(_loaderData.path + ".swf"), context);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadingProgress, false, 0, true);
		}
		
		protected function onLoadingProgress(ev:ProgressEvent):void {
			setProgress(ev.bytesLoaded / ev.bytesTotal);
		}
		
		protected function onError(e:IOErrorEvent):void {
			trace('shit: ' + e.text);
		}
		
		protected function onAssetLoaded(ev:Event):void {
			setFinished();
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onAssetLoaded, false);
		}
		
		public function getClass(classname:String):Class {
			//if (_loader.contentLoaderInfo.applicationDomain.hasDefinition(classname)) {
				//return _loader.contentLoaderInfo.applicationDomain.getDefinition(classname) as Class;
			//}
			if (_assetDomain.hasDefinition(classname)) {
				return _assetDomain.getDefinition(classname) as Class;
			}
			
			return null;
		}
		
		//public function set assetLoaderCommand(cmd:AssetLoaderCommand):void {
			/* TODO
			 * hier die assetdomain ect übernehmen
			 */
			//_loader = cmd.loader;
			//_assetDomain = cmd.assetDomain;
		//}
		
		public function get assetDomain():ApplicationDomain { return _assetDomain; }
		
		override public function set asset(value:Object):void {
			if (value is ApplicationDomain) {
				_assetDomain = value as ApplicationDomain;
				setFinished();
			}
		}
		
		override public function get asset():Object {
			return _assetDomain;
		}
		
		//public function set assetDomain(value:ApplicationDomain):void {
			//_assetDomain = value;
		//}
	}

}