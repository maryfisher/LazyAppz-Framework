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
			trace("[DynamicIdSQLController] createDBFile", _dbFileId);
            super.createDBFile();
		}
		
		override public function registerRequest(cmd:NetCommand):void {
			_savegame = int(cmd.requestSpecs);
			createDBFile();
			if (!_dbFile) {
				if(CONFIG::debug){
					trace("[DynamicIdSQLController] registerRequest no id for db file specified.");
				}else {
					throw new Error("[DynamicIdSQLController] registerRequest no id for db file specified.");
				}
				return;
			}
			
			super.registerRequest(cmd);
		}
	}

}