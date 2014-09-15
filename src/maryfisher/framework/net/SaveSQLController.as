package maryfisher.framework.net {
	import flash.filesystem.File;
    import maryfisher.framework.command.net.NetCommand;
	import maryfisher.framework.command.net.SQLRequest;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SaveSQLController extends BaseSQLController {
        
        private var _savegame:String;
        private var _prefix:String;
		
		public function SaveSQLController(path:String, dbFileId:String, prefix:String, controllerID:String) {
			super(path, dbFileId, controllerID);
            _prefix = prefix;
            
        }
		
		override protected function createDBFile():void {
			var resources:File = File.documentsDirectory;
			var ssc:File = new File(resources.nativePath + _path);
			ssc.createDirectory();
			_dbFile = ssc.resolvePath(_prefix + _savegame + _dbFileId);
		}
		
        override public function registerRequest(cmd:NetCommand):void 
        {
            _savegame = cmd.requestSpecs || "";
            createDBFile();
            
            super.registerRequest(cmd);
        }
	}

}