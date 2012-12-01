package maryfisher.framework.command.asset {
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.VideoEvent;
	import maryfisher.framework.command.loader.AssetLoaderCommand;
	import maryfisher.framework.command.loader.LoaderCommand;
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
	public class LoadAssetCommand extends BaseAssetCommand{
		
		//private var _callback:IAssetCallback;
		
		public function LoadAssetCommand(id:String, callback:IAssetCallback, fileId:String = "", addView:Boolean = false, assetBuilderId:String = null) {
			super(id, callback, addView);
			_fileId = fileId;
			
			_assetBuilderId = assetBuilderId;
			//_callback = callback;
			//super(id, fileId);
			
			new AssetLoaderCommand(id, fileId, onAssetFinished);
		}
		
		private function onAssetFinished(cmd:LoaderCommand):void {
			
			var obj:Sprite = (cmd as AssetLoaderCommand).content;
			buildAsset(obj);
			
		}
		
		override protected function buildAsset(obj:*):void {
			if (obj is maryfisher.framework.view.IAssetBuilder) {
				_assetBuilder = obj as IAssetBuilder;
				if (_assetBuilderId != null) {
					_viewComponent = _assetBuilder.getViewComponent(_assetBuilderId);
					_viewComponent.addOnFinished(onViewFinished);
					return;
				}
			}else {
				super.buildAsset(obj);
			}
		}
	}

}