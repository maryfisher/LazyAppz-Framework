package maryfisher.framework.command.asset {
	
	import flash.display.BitmapData;
	import flash.media.Sound;
	import flash.utils.getQualifiedClassName;
	import maryfisher.framework.command.AbstractCommand;
	import maryfisher.framework.command.loader.AssetLoaderCommand;
	import maryfisher.framework.command.loader.ImageLoaderCommand;
	import maryfisher.framework.command.loader.LoaderCommand;
	import maryfisher.framework.command.loader.SoundLoaderCommand;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.core.AssetController;
	import maryfisher.framework.data.AssetData;
	import maryfisher.framework.event.ViewEvent;
	import maryfisher.framework.view.IAssetBuilder;
	import maryfisher.framework.view.IClonableViewComponent;
	import maryfisher.framework.view.IImageBuilder;
	import maryfisher.framework.view.IMovieClip;
	import maryfisher.framework.view.IViewComponent;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LoadAssetCommand extends AbstractCommand {
		
		private var _image:BitmapData;
		private var _obj:Object;
		private var _imageBuilder:IImageBuilder;
		protected var _soundComponent:Sound;
		protected var _movieComponent:IMovieClip;
		protected var _viewComponent:IViewComponent;
		protected var _assetBuilderId:String;
		protected var _assetBuilder:IAssetBuilder;
		/** TODO
		 * 
		 */
		//protected var _spriteSheet:ISpriteSheet;
		protected var _addView:Boolean;
		protected var _finishedLoading:Signal;
		protected var _id:String;
		protected var _fileId:String;
		protected var _clonableViewComponent:IClonableViewComponent;
		
		public function LoadAssetCommand(id:String, callback:IAssetCallback, fileId:String = "", addView:Boolean = false, assetBuilderId:String = null, executeImmediatly:Boolean = true) {
			_fileId = fileId;
			_assetBuilderId = assetBuilderId;
			_id = id;
			_addView = addView;
			
			_finishedLoading = new Signal(LoadAssetCommand);
			_finishedLoading.addOnce(callback.assetFinished);
			
			super(executeImmediatly);
		}
		
		override public function execute():void {
			AssetController.registerAssetCommand(this);
		}
		
		public function loadAsset(asData:AssetData):void {
			if(!asData || asData.assetClass == AssetLoaderCommand){
				new AssetLoaderCommand(id, fileId, onAssetFinished);
			}else if (asData.assetClass == SoundLoaderCommand) {
				new SoundLoaderCommand(id, fileId, onAssetFinished);
			}else if (asData.assetClass == ImageLoaderCommand) {
				new ImageLoaderCommand(id, fileId, onAssetFinished);
			}else {
				new asData.assetClass(id, fileId, onAssetFinished);
			}
		}
		
		private function onAssetFinished(cmd:LoaderCommand):void {
			buildAsset(cmd.asset);
		}
		
		public function buildAsset(obj:*):void {
			
			if (obj is maryfisher.framework.view.IAssetBuilder) {
				_assetBuilder = obj as IAssetBuilder;
				if (_assetBuilderId != null) {
					_viewComponent = _assetBuilder.getViewComponent(_assetBuilderId);
					_viewComponent.addListener(ViewEvent.ON_FINISHED, onViewFinished);
					_viewComponent.checkFinished();
					return;
				}
			}else if (obj is IClonableViewComponent) {
				_clonableViewComponent = (obj as IClonableViewComponent);
				_clonableViewComponent.addListener(ViewEvent.ON_FINISHED, onClonableViewFinished);
				_clonableViewComponent.checkFinished();
				return;
			/** TODO
			 * 
			 */
			//}else if (obj is ISpriteSheet) {
				//_spriteSheet = obj as ISpriteSheet;
			}else if (obj is IViewComponent) {
				_viewComponent = obj as IViewComponent;
				_viewComponent.addListener(ViewEvent.ON_FINISHED, onViewFinished);
				_viewComponent.checkFinished();
				
				return;
			}else if (obj is Sound) {
				_soundComponent = (obj as Sound);
			}else if (obj is BitmapData) {
				_image = obj as BitmapData;
			}else if (obj is IMovieClip) {
				_movieComponent = obj as IMovieClip;
			}else if (obj is IImageBuilder) {
				_imageBuilder = obj as IImageBuilder;
			}else {
				_obj = obj;
				trace("[LoadAssetCommand] buildAsset: Problem with asset type:", getQualifiedClassName(obj));
			}
			setFinished();
		}
		
		protected function onClonableViewFinished(e:ViewEvent):void {
			/* TODO
			 * original is never used
			 */
			_viewComponent = _clonableViewComponent.clone();
			_viewComponent.addListener(ViewEvent.ON_FINISHED, onViewFinished);
			_viewComponent.checkFinished();
		}
		
		public function setFinished():void {
			_finishedLoading.dispatch(this);
			_finishedExecutionSignal.dispatch();
		}
		
		protected function onViewFinished(e:ViewEvent):void {
			
			if (_addView) new ViewCommand(_viewComponent, ViewCommand.ADD_VIEW);
			setFinished();
		}
		
		public function get assetBuilder():IAssetBuilder {
			return _assetBuilder;
		}
		
		public function get viewComponent():IViewComponent {
			return _viewComponent;
		}
		
		public function get movieComponent():IMovieClip {
			return _movieComponent;
		}
		
		public function get clonableViewComponent():IClonableViewComponent {
			return _clonableViewComponent;
		}
		
		public function get soundComponent():Sound {
			return _soundComponent;
		}
		
		public function get image():BitmapData {
			return _image;
		}
		
		public function get obj():Object {
			return _obj;
		}
		
		public function get imageBuilder():IImageBuilder {
			return _imageBuilder;
		}
		
		/** TODO
		 * 
		 */
		//public function get spriteSheet():ISpriteSheet {
			//return _spriteSheet;
		//}
		
		public function get id():String {
			return _id;
		}
		
		public function get fileId():String {
			return _fileId;
		}
	}

}