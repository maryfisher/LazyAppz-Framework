package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AssetData {
		
		public var load:Boolean;
		public var assetClass:Class;
		public var cacheAsset:Boolean;
		
		public function AssetData(assetClass:Class, cacheAsset:Boolean, load:Boolean) {
			this.load = load;
			this.cacheAsset = cacheAsset;
			this.assetClass = assetClass;
			
		}
		
	}

}