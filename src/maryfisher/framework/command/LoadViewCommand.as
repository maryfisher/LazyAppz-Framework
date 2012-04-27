package maryfisher.framework.command {
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import maryfisher.framework.command.loader.AssetLoaderCommand;
	import maryfisher.framework.command.loader.LoaderCommand;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.view.IAssetBuilder;
	import maryfisher.framework.view.IClonableViewComponent;
	import maryfisher.framework.view.ISpriteSheet;
	import maryfisher.framework.view.IViewComponent;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LoadViewCommand {
		
		//private var _callback:IViewLoadingCallback;
		private var _viewComponent:IViewComponent;
		private var _assetBuilderId:String;
		private var _assetBuilder:IAssetBuilder;
		private var _spriteSheet:ISpriteSheet;
		private var _addView:Boolean;
		private var _finishedLoading:Signal;
		private var _id:String;
		private var _fileId:String;
		
		public function LoadViewCommand(id:String, callback:IViewLoadingCallback, fileId:String = "", addView:Boolean = false, assetBuilderId:String = null) {
			_fileId = fileId;
			_id = id;
			//trace(id, fileId);
			_addView = addView;
			_assetBuilderId = assetBuilderId;
			//_callback = callback;
			_finishedLoading = new Signal(LoadViewCommand);
			_finishedLoading.addOnce(callback.viewLoadingFinished);
			//super(id, fileId);
			
			new AssetLoaderCommand(id, fileId, onAssetFinished);
		}
		
		private function onAssetFinished(cmd:LoaderCommand):void {
			
		//}
		
		//override public function get asset():Object {
			//return _assetBuilder || _viewComponent || _bitmapData;
		//}
		
		//override public function set asset(value:Object):void {
			//var obj:Object = new value();
			var obj:Sprite = (cmd as AssetLoaderCommand).content;
			//trace(describeType(obj));
			if (obj is maryfisher.framework.view.IAssetBuilder) {
				_assetBuilder = obj as IAssetBuilder;
				//trace("id", _id, "assetBuilderId", _assetBuilderId, _assetBuilderId != null)
				if (_assetBuilderId != null) {
					_viewComponent = _assetBuilder.getViewComponent(_assetBuilderId);
					//if (_addView) new ViewCommand(_viewComponent, ViewCommand.ADD_VIEW);
					_viewComponent.addOnFinished(onViewFinished);
					return;
				}
			}else if (obj is IViewComponent) {
				//if (obj is IClonableViewComponent) {
					//_viewComponent = (obj as IClonableViewComponent).clone();
					//onViewFinished();
				//}else{
					_viewComponent = obj as IViewComponent;
				//}
				_viewComponent.addOnFinished(onViewFinished);
				
				return;
				//if(_addView) new ViewCommand(_viewComponent, ViewCommand.ADD_VIEW);
			}else if (obj is ISpriteSheet) {
				_spriteSheet = obj as ISpriteSheet;
			}
			setFinished();
		}
		
		public function setFinished():void {
			_finishedLoading.dispatch(this);
		}
		
		private function onViewFinished():void {
			/* TODO
			 * das hier hat nur den Nachteil, dass das Original nie verwendet wird
			 */
			if (_viewComponent is IClonableViewComponent) {
				_viewComponent = (_viewComponent as IClonableViewComponent).clone();
			}
			if (_addView) new ViewCommand(_viewComponent, ViewCommand.ADD_VIEW);
			setFinished();
		}
		
		public function get assetBuilder():IAssetBuilder {
			return _assetBuilder;
		}
		
		public function get viewComponent():IViewComponent {
			return _viewComponent;
		}
		
		public function get spriteSheet():ISpriteSheet {
			return _spriteSheet;
		}
		
		public function get id():String {
			return _id;
		}
		
		public function get fileId():String {
			return _fileId;
		}
	}

}