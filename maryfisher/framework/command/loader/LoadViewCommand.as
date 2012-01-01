package maryfisher.framework.command.loader {
	import maryfisher.framework.command.loader.LoaderCommand;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.data.LoaderData;
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
		private var _loaderCommand:LoaderCommand;
		
		public function LoadViewCommand(id:String, callback:IViewLoadingCallback, assetBuilderId:String = null) {
			_assetBuilderId = assetBuilderId;
			_callback = callback;
			_finishedLoading = new Signal(LoadViewCommand);
			_finishedLoading.addOnce(_callback.viewLoadingFinished);
			super(id);
		}
		
		override public function get asset():Object {
			return _assetBuilder || _viewComponent;
		}
		
		override public function set asset(value:Object):void {
			//if (value is IViewComponent) {
				//_viewComponent = value as IViewComponent;
				//return;
			//}
			var obj:Object = new value();
			if (obj is IAssetBuilder) {
				_assetBuilder = obj as IAssetBuilder;
				if (_assetBuilderId) {
					_viewComponent = _assetBuilder.getViewComponent(_assetBuilderId);
					new ViewCommand(_viewComponent, ViewCommand.ADD_VIEW);
				}
			}else if (obj is IViewComponent) {
				_viewComponent = obj as IViewComponent;
				new ViewCommand(_viewComponent, ViewCommand.ADD_VIEW);
			}
			setFinished();
		}
		
		public function set loaderCommand(value:LoaderCommand):void {
			_loaderCommand = value;
		}
		
		public function get assetBuilder():IAssetBuilder {
			return _assetBuilder;
		}
		
		public function get viewComponent():IViewComponent {
			return _viewComponent;
		}
	}

}