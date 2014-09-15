package maryfisher.framework.net {
	import flash.filesystem.File;
	import maryfisher.framework.command.net.NetCommand;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SaveSQLController extends BaseSQLController {
		
		private var _savegame:int;
		private var _prefix:String;
		
		public function SaveSQLController(path:String, dbFileId:String, prefix:String, controllerID:String) {
			super(path, dbFileId, controllerID);
			_prefix = prefix;
		
		}
		
		override protected function createDBFile():void {
			if (_savegame <= 0)
				return;
			
			var resources:File = File.documentsDirectory;
			var ssc:File = new File(resources.nativePath + _path);
			ssc.createDirectory();
			_dbFile = ssc.resolvePath(_prefix + _savegame + _dbFileId);
		}
		
		override public function registerRequest(cmd:NetCommand):void {
			_savegame = int(cmd.requestSpecs);
			createDBFile();
			//if (!_dbFile) {
			//return;
			//}
			
			super.registerRequest(cmd);
		}
	}

}