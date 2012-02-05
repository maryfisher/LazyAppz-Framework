package maryfisher.framework.command.loader {
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import maryfisher.framework.config.LoaderConfig;
	import maryfisher.framework.data.LoaderData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseLoaderCommand extends LoaderCommand {
		
		protected var _loader:Loader;
		
		public function BaseLoaderCommand(id:String, priority:int=LoaderConfig.WHENEVER_PRIORITY) {
			super(id, priority);
			
		}
		
		override public function loadAsset(loaderData:LoaderData):void {
			super.loadAsset(loaderData);
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onAssetLoaded, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadingProgress, false, 0, true);
		}
		
		protected function onLoadingProgress(e:ProgressEvent):void {
			setProgress(e.bytesLoaded / e.bytesTotal);
		}
		
		protected function onError(e:IOErrorEvent):void {
			trace('shit: ' + e.text);
		}
		
		protected function onAssetLoaded(e:Event):void {
			
		}
	}

}