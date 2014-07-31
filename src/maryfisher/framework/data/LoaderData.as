package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LoaderData {
		
		public var path:String;
		public var description:String;
		/**
		 * caches the class
		 */
		public var cacheClass:Boolean;
		/**
		 * caches an instance of the class to be reused
		 */
		public var reuse:Boolean;
		
		public function LoaderData(path:String, cacheClass:Boolean = false, reuse:Boolean = false, description:String = "") {
			this.description = description;
			this.path = path;
			this.cacheClass = cacheClass;
			this.reuse = reuse;
		}
		
		public function toString():String {
			return "[LoaderData path=" + path + " description=" + description + " doCache=" + cacheClass + " reuse=" + reuse +
						"]";
		}
	}

}