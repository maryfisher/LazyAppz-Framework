package maryfisher.framework.command.asset {
	import maryfisher.framework.command.asset.BaseAssetCommand;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IAssetCallback {
		function assetFinished(cmd:LoadAssetCommand):void;
	}
	
}