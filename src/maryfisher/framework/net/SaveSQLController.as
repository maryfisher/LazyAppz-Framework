package maryfisher.framework.net {
	import flash.filesystem.File;
	import maryfisher.framework.command.net.SQLRequest;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SaveSQLController extends BaseSQLController {
		
		public function SaveSQLController(path:String, dbFileId:String, controllerID:String) {
			super(path, dbFileId, controllerID);
			
		}
		
		override protected function createDBFile():void {
			var resources:File = File.documentsDirectory;
			var ssc:File = new File(resources.nativePath + _path);
			ssc.createDirectory();
			_dbFile = ssc.resolvePath(_dbFileId);
		}
		
	}

}