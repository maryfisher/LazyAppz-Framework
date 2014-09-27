package maryfisher.framework.net {
	import flash.data.SQLConnection;
	import flash.events.Event;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import maryfisher.framework.command.net.NetCommand;
	import maryfisher.framework.command.net.SQLRequest;
	import maryfisher.framework.net.BaseSQLController;
	
	/**
	 * ...
	 * @author maryfisher
	 */
	public class ConfigSQLController extends BaseSQLController {
		
		private var _configId:int;
		
		public function ConfigSQLController(path:String, dbFileId:String, controllerID:String) {
			super(path, dbFileId, controllerID);
		
		}
		
		override protected function createDBFile():void {
			if (_configId <= 0)
				return;
			
			var resources:File = File.applicationDirectory;
			var ssc:File = new File(resources.nativePath + _path);
			ssc.createDirectory();
			_dbFile = ssc.resolvePath(_dbFileId + _configId);
		}
		
		override public function registerRequest(cmd:NetCommand):void {
			_configId = int(cmd.requestSpecs);
			createDBFile();
			if (!_dbFile)
				return;
			super.registerRequest(cmd);
		}
	
	}

}