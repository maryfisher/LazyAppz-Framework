package maryfisher.framework.core {
	import flash.utils.Dictionary;
	import maryfisher.framework.command.net.NetRequest;
	import maryfisher.framework.data.NetData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class NetController {
		
		static private var _instance:NetController;
		private var _netDatas:Dictionary;
		
		public function NetController() {
			
		}
		
		static private function getInstance():NetController {
			if (!_instance) {
				_instance = new NetController();
				
			}
			return _instance;
		}
		
		static public function init(netDatas:Dictionary):void {
			getInstance()._netDatas = netDatas;
		}
		
		static public function registerCommand(cmd:NetRequest):void {
			_instance.netrequest = cmd;
		}
		
		private function set netrequest(cmd:NetRequest):void {
			var data:NetData = _netDatas[cmd.id];
			cmd.sendRequest(data);
		}
		
		/** TODO
		 * results annehmen, aufsplitten (falls etwas mitgeschickt wurde, das nicht requested wurde
		 */
	}

}