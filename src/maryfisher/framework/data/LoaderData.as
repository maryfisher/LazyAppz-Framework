package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LoaderData {
		
		//private var _id:String;
		public var path:String;
		//private var _type:Class; /* LoaderCommand type => xml, view, file ect */
		public var description:String;
		public var doCache:Boolean;
		public var reuse:Boolean;
		
		public function LoaderData(path:String, doCache:Boolean = false, reuse:Boolean = false, description:String = "") {
			this.description = description;
			this.path = path;
			this.doCache = doCache;
			this.reuse = reuse;
		}
		
	}

}