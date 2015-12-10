package maryfisher.framework.net {
	import flash.filesystem.File;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ApplicationSQLController extends BaseSQLController {
		private var _useAppDir:Boolean;
		
		public function ApplicationSQLController(path:String, dbFileId:String, controllerID:String, useAppDir:Boolean = true, isReadOnly:Boolean = true) {
			_useAppDir = useAppDir;
			super(path, dbFileId, controllerID, isReadOnly);
		
		}
		
		override protected function createDBFile():void {
			var resources:File = _useAppDir ? File.applicationDirectory : File.documentsDirectory;
			var ssc:File = new File(resources.nativePath + _path);
			ssc.createDirectory();
			_dbFile = ssc.resolvePath(_dbFileId);
		}
	
	}

}