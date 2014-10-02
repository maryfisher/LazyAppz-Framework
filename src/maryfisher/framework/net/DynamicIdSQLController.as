package maryfisher.framework.net {
	import flash.filesystem.File;
	import maryfisher.framework.command.net.NetCommand;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class DynamicIdSQLController extends ApplicationSQLController {
		
		private var _savegame:int;
		private var _prefix:String;
        private var _suffix:String;
		
		public function DynamicIdSQLController(path:String, suffix:String, prefix:String, controllerID:String, useAppDir:Boolean) {
			super(path, suffix, controllerID, useAppDir);
			_prefix = prefix;
		    _suffix = suffix;
		}
		
		override protected function createDBFile():void {
			if (_savegame <= 0)
				return;
            _dbFileId = _prefix + _savegame + _suffix;
            super.createDBFile();
			
			//var resources:File = File.documentsDirectory;
			//var ssc:File = new File(resources.nativePath + _path);
			//ssc.createDirectory();
			//_dbFile = ssc.resolvePath(_prefix + _savegame + _dbFileId);
		}
		
		override public function registerRequest(cmd:NetCommand):void {
			_savegame = int(cmd.requestSpecs);
			createDBFile();
			if (!_dbFile)
				return;
			
			super.registerRequest(cmd);
		}
	}

}