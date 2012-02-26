package maryfisher.framework.command.loader {
	
	import flash.display.BitmapData;
	import maryfisher.framework.command.loader.LoaderCommand;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.view.IAssetBuilder;
	import maryfisher.framework.view.IViewComponent;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LoadViewCommand extends LoaderCommand {
		
		private var _callback:IViewLoadingCallback;
		private var _viewComponent:IViewComponent;
		private var _assetBuilderId:String;
		private var _assetBuilder:IAssetBuilder;
		private var _bitmapData:BitmapData;
		private var _addView:Boolean;
		
		public function LoadViewCommand(id:String, callback:IViewLoadingCallback, addView:Boolean = false, assetBuilderId:String = null) {
			_addView = addView;
			_assetBuilderId = assetBuilderId;
			_callback = callback;
			_finishedLoading = new Signal(LoadViewCommand);
			_finishedLoading.addOnce(_callback.viewLoadingFinished);
			super(id);
		}
		
		override public function get asset():Object {
			return _assetBuilder || _viewComponent || _bitmapData;
		}
		
		override public function set asset(value:Object):void {
			var obj:Object = new value();
			//trace(describeType(obj));
			if (obj is maryfisher.framework.view.IAssetBuilder) {
				_assetBuilder = obj as IAssetBuilder;
				if (_assetBuilderId) {
					_viewComponent = _assetBuilder.getViewComponent(_assetBuilderId);
					if (_addView) new ViewCommand(_viewComponent, ViewCommand.ADD_VIEW);
					_viewComponent.finishedSignal.add(onViewFinished);
					return;
				}
			}else if (obj is IViewComponent) {
				_viewComponent = obj as IViewComponent;
				if(_addView) new ViewCommand(_viewComponent, ViewCommand.ADD_VIEW);
			}else if (obj is BitmapData) {
				_bitmapData = obj as BitmapData;
			}
			setFinished();
		}
		
		private function onViewFinished():void {
			setFinished();
		}
		
		public function get assetBuilder():IAssetBuilder {
			return _assetBuilder;
		}
		
		public function get viewComponent():IViewComponent {
			return _viewComponent;
		}
		
		public function get bitmapData():BitmapData {
			return _bitmapData;
		}
	}

}