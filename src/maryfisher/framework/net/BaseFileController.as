package maryfisher.framework.net {
	import flash.filesystem.File;
	import maryfisher.framework.command.net.FileRequest;
	import maryfisher.framework.command.net.NetCommand;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseFileController implements INetController {
		
		private var _controllerID:String;
		private var _baseFile:File;
		private var _path:String;
		
		public function BaseFileController(controllerID:String, baseFile:File, path:String) {
			_path = path;
			_baseFile = baseFile;
			_controllerID = controllerID;
			
		}
		
		/* INTERFACE maryfisher.framework.net.INetController */
		
		public function get controllerID():String {
			return _controllerID;
		}
		
		public function registerRequest(cmd:NetCommand):void {
			var r:FileRequest = cmd.netRequest as FileRequest;
			if (!r) {
				if (cmd.netRequest) {
					throw new Error("[BaseFileController] registerRequest: Stupid, this is the wrong request type!")
				}
				return;
			}
			r.pathPrefix = _path;
			r.baseFile = _baseFile;
			cmd.sendRequest();
		}
		
	}

}