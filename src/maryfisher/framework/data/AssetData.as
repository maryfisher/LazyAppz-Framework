package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AssetData {
		
		public var assetClass:Class;
		public var cacheAsset:Boolean;
		
		public function AssetData(assetClass:Class, cacheAsset:Boolean) {
			this.cacheAsset = cacheAsset;
			this.assetClass = assetClass;
			
		}
		
	}

}