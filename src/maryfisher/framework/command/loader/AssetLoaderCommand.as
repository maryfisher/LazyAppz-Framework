package maryfisher.framework.command.loader {
	
	//import flash.display.Loader;
	import com.wispagency.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.utils.getQualifiedClassName;
	import maryfisher.framework.config.LoaderConfig;
	import maryfisher.framework.data.LoaderData;
	import maryfisher.framework.view.IClonableViewComponent;
	import maryfisher.framework.view.IViewComponent;
	import org.osflash.signals.Signal;
	
	
	
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AssetLoaderCommand extends LoaderCommand{
		protected var _assetDomain:ApplicationDomain;
		protected var _loader:Loader;
		protected var _asset:Sprite;
		
		/* TODO
		 * assetType => SWF, PNG/JPG
		 */
		public function AssetLoaderCommand(id:String, fileId:String, callback:Function, priority:int = LoaderConfig.WHENEVER_PRIORITY, executeInstantly:Boolean = true) {
			_finishedLoading = new Signal(LoaderCommand);
			_finishedLoading.addOnce(callback);
			super(id, fileId, priority, executeInstantly);
		}
		
		override public function loadAsset(loaderData:LoaderData):void {
			super.loadAsset(loaderData);
			
			//_assetDomain = new ApplicationDomain();
			var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			context.allowCodeImport = true;
			
			
			_loader = new Loader();
			
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onAssetLoaded, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError, false, 0, true);
			_loader.load(new URLRequest(_loaderData.path + _fileId + ".swf"), context);
			//_loader.load(new URLRequest(_loaderData.path + ".swf"));
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
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onAssetLoaded, false);
			//_loader.unload();
			//if (_asset is IViewComponent) {
				//(_asset as IViewComponent).addOnFinished(onViewFinished);
				//return;
			//}
			
			setFinished();
		}
		
		private function onViewFinished():void {
			setFinished();
		}
		
		override public function leachLoading(cmd:LoaderCommand):void {
			_loader = (cmd as AssetLoaderCommand).loader;
			super.leachLoading(cmd);
		}
		
		public function get assetClass():Class {
			if (_asset) {
				
				var classname:String = getQualifiedClassName(_asset);
				var assetClass:Class = _loader.contentLoaderInfo.applicationDomain.getDefinition(classname) as Class;
				
				return assetClass;
			}
			return null;
		}
		
		//public function get content():Sprite {
			//return _asset;
		//}
		
		override public function get asset():Object {
			/** TODO
			 * this a good idea?? messing with the LoadAssetCommand buildAsset method
			 */
			//if (_loaderData.reuse) {
				return _asset;
			//}
			//return assetClass;
		}
		
		override public function get cacheAsset():Object {
			/** TODO
			 * this a good idea?? messing with the LoadAssetCommand buildAsset method
			 */
			if (_loaderData.reuse) {
				return _asset;
			}
			return assetClass;
		}
		
		override public function set asset(value:Object):void {
			if (value is Sprite) {
				_asset = value as Sprite;
			}else if (value is Class) {
				_asset = new value();
			}
			//setFinished();
		}
		
		public function get loader():Loader {
			return _loader;
		}
	}
}