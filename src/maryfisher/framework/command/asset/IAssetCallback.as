package maryfisher.framework.command.asset {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IAssetCallback {
		function assetFinished(cmd:LoadAssetCommand):void;
	}
	
}