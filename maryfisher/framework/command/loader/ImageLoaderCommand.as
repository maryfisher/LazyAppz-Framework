package maryfisher.framework.command.loader {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.URLRequest;
	import maryfisher.framework.config.LoaderConfig;
	import maryfisher.framework.data.LoaderData;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ImageLoaderCommand extends BaseLoaderCommand {
		
		private var _image:BitmapData;
		private var _callback:IImageLoadingCallback;
		private var _fileId:String;
		
		public function ImageLoaderCommand(callback:IImageLoadingCallback, id:String, fileId:String, priority:int=LoaderConfig.WHENEVER_PRIORITY) {
			_fileId = fileId;
			_callback = callback;
			_finishedLoading = new Signal(ImageLoaderCommand);
			_finishedLoading.add(_callback.imageLoadingFinished);
			super(id, priority);
		}
		
		override public function get fileId():String {
			return _fileId;
		}
		
		override public function loadAsset(loaderData:LoaderData):void {
			super.loadAsset(loaderData);
			
			_loader.load(new URLRequest(_loaderData.path + _fileId));
		}
		
		protected override function onAssetLoaded(e:Event):void {
			_image = (_loader.content as Bitmap).bitmapData;
			setFinished();
		}
		
		public function get image():BitmapData {
			return _image;
		}
		
		override public function get asset():Object {
			return _image;
		}
		
		override public function set asset(value:Object):void {
			_image = value as BitmapData;
		}
	}

}