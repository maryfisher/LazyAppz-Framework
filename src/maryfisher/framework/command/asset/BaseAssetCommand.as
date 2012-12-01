package maryfisher.framework.command.asset {
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.event.ViewEvent;
	import maryfisher.framework.view.IAssetBuilder;
	import maryfisher.framework.view.IClonableViewComponent;
	import maryfisher.framework.view.ISpriteSheet;
	import maryfisher.framework.view.IViewComponent;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseAssetCommand {
		
		protected var _viewComponent:IViewComponent;
		protected var _assetBuilderId:String;
		protected var _assetBuilder:IAssetBuilder;
		protected var _spriteSheet:ISpriteSheet;
		protected var _addView:Boolean;
		protected var _finishedLoading:Signal;
		protected var _id:String;
		protected var _fileId:String;
		protected var _clonableViewComponent:IClonableViewComponent;
		
		
		public function BaseAssetCommand(id:String, callback:IAssetCallback, addView:Boolean = false) {
			_id = id;
			//trace(id, fileId);
			_addView = addView;
			_finishedLoading = new Signal(LoadAssetCommand);
			_finishedLoading.addOnce(callback.assetFinished);
		}
		
		protected function buildAsset(obj:*):void {
			if (obj is IViewComponent) {
				_viewComponent = obj as IViewComponent;
				_viewComponent.addOnFinished(onViewFinished);
				
				return;
			}else if (obj is IClonableViewComponent) {
				_clonableViewComponent = (obj as IClonableViewComponent);
				_clonableViewComponent.addOnFinished(onClonableViewFinished);
				return;
			}else if (obj is ISpriteSheet) {
				_spriteSheet = obj as ISpriteSheet;
			}
			setFinished();
		}
		
		protected function onClonableViewFinished(e:ViewEvent):void {
			_viewComponent = _clonableViewComponent.clone();
			if (_addView) new ViewCommand(_viewComponent, ViewCommand.ADD_VIEW);
			setFinished();
		}
		
		public function setFinished():void {
			_finishedLoading.dispatch(this);
		}
		
		protected function onViewFinished(e:ViewEvent):void {
			/* TODO
			 * das hier hat nur den Nachteil, dass das Original nie verwendet wird
			 */
			if (_viewComponent is IClonableViewComponent) {
				_clonableViewComponent = (_viewComponent as IClonableViewComponent)
				_viewComponent = _clonableViewComponent.clone();
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
		
		public function get clonableViewComponent():IClonableViewComponent {
			return _clonableViewComponent;
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