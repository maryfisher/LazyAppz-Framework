package maryfisher.framework.command.asset {
	import maryfisher.framework.core.AssetController;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class InitAssetCommand extends BaseAssetCommand{
		
		public function InitAssetCommand(id:String, callback:IAssetCallback, addView:Boolean = false) {
			super(id, callback, addView);
			
			AssetController.registerCommand(this);
		}
		
		public function setAsset(obj:*):void {
			buildAsset(obj);
		}
		
	}

}