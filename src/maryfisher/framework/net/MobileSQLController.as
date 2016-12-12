package maryfisher.framework.net {
	import flash.filesystem.File;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class MobileSQLController extends BaseSQLController {
		private var _useAppDir:Boolean;
		
		public function MobileSQLController(path:String, dbFileId:String, controllerID:String, useAppDir:Boolean = true, isReadOnly:Boolean = true) {
			_useAppDir = useAppDir;
			super(path, dbFileId, controllerID, isReadOnly);
		}
		
		override protected function createDBFile():void {
			var ssc:File;
			if (!_useAppDir){
				ssc = new File(File.applicationStorageDirectory.url + _path);
				ssc.createDirectory();
			} else {
				ssc = new File(File.applicationDirectory.url + _path);
			}
			
			_dbFile = ssc.resolvePath(_dbFileId);
		}
	
	}

}