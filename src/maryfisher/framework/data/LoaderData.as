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
		public var doCache:Boolean;
		/**
		 * caches the actual object
		 */
		public var reuse:Boolean;
		
		public function LoaderData(path:String, doCache:Boolean = false, reuse:Boolean = false, description:String = "") {
			this.description = description;
			this.path = path;
			this.doCache = doCache;
			this.reuse = reuse;
		}
		
		public function toString():String {
			return "[LoaderData path=" + path + " description=" + description + " doCache=" + doCache + " reuse=" + reuse +
						"]";
		}
	}

}