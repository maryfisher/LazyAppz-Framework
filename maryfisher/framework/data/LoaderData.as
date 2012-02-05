package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LoaderData {
		
		private var _id:String;
		private var _path:String;
		//private var _type:Class; /* LoaderCommand type => xml, view, file ect */
		private var _description:String;
		private var _doCache:Boolean;
		
		public function LoaderData(id:String, path:String, doCache:Boolean = false, description:String = "") {
			_id = id;
			_description = description;
			_path = path;
			_doCache = doCache;
		}
		
		public function get path():String {
			return _path;
		}
		
		public function get doCache():Boolean {
			return _doCache;
		}
		
		public function get description():String {
			return _description;
		}
		
	}

}