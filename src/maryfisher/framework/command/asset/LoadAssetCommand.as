package maryfisher.framework.command.asset {
	
	import flash.display.Sprite;
	import maryfisher.framework.command.loader.AssetLoaderCommand;
	import maryfisher.framework.command.loader.LoaderCommand;
	import maryfisher.framework.command.loader.SoundLoaderCommand;
	import maryfisher.framework.command.sound.SoundCommand;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.core.AssetController;
	import maryfisher.framework.data.AssetData;
	import maryfisher.framework.event.ViewEvent;
	import maryfisher.framework.sound.ISoundComponent;
	import maryfisher.framework.view.IAssetBuilder;
	import maryfisher.framework.view.IClonableViewComponent;
	import maryfisher.framework.view.IViewComponent;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LoadAssetCommand {
		
		//private var _callback:IAssetCallback;
		protected var _soundComponent:ISoundComponent;
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
		
		public function LoadAssetCommand(id:String, callback:IAssetCallback, fileId:String = "", addView:Boolean = false, assetBuilderId:String = null) {
			_fileId = fileId;
			_assetBuilderId = assetBuilderId;
			_id = id;
			_addView = addView;
			
			_finishedLoading = new Signal(LoadAssetCommand);
			_finishedLoading.addOnce(callback.assetFinished);
			
			execute();
		}
		
		public function execute():void {
			AssetController.registerAssetCommand(this);
		}
		
		public function loadAsset(asData:AssetData):void {
			/** TODO
			 * 
			 */
			if(!asData || asData.assetClass == AssetLoaderCommand){
				new AssetLoaderCommand(id, fileId, onAssetFinished);
			}else if (asData.assetClass == SoundLoaderCommand) {
				
			}
		}
		
		private function onAssetFinished(cmd:LoaderCommand):void {
			
			//var obj:Sprite = (cmd as AssetLoaderCommand).asset;
			buildAsset(cmd.asset);
			
		}
		
		public function buildAsset(obj:*):void {
			if (obj is maryfisher.framework.view.IAssetBuilder) {
				_assetBuilder = obj as IAssetBuilder;
				if (_assetBuilderId != null) {
					_viewComponent = _assetBuilder.getViewComponent(_assetBuilderId);
					_viewComponent.addOnFinished(onViewFinished);
					return;
				}
			}else if (obj is IViewComponent) {
				_viewComponent = obj as IViewComponent;
				_viewComponent.addOnFinished(onViewFinished);
				
				return;
			}else if (obj is IClonableViewComponent) {
				_clonableViewComponent = (obj as IClonableViewComponent);
				_clonableViewComponent.addOnFinished(onClonableViewFinished);
				return;
			/** TODO
			 * 
			 */
			//}else if (obj is ISpriteSheet) {
				//_spriteSheet = obj as ISpriteSheet;
			}else if (obj is ISoundComponent) {
				/** TODO
				 * 
				 */
				_soundComponent = (obj as ISoundComponent);
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
			 * original is never used
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
		
		public function get soundComponent():ISoundComponent {
			return _soundComponent;
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