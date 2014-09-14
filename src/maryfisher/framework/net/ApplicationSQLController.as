package maryfisher.framework.net {
	import flash.filesystem.File;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ApplicationSQLController extends BaseSQLController {
		
		public function ApplicationSQLController(path:String, dbFileId:String, controllerID:String) {
			super(path, dbFileId, controllerID);
			
		}
		
		override protected function createDBFile():void {
			var resources:File = File.applicationDirectory;
			var ssc:File = new File(resources.nativePath + _path);
			ssc.createDirectory();
			_dbFile = ssc.resolvePath(_dbFileId);
		}
		
	}

}