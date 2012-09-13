package maryfisher.framework.core {
	import flash.utils.Dictionary;
	import maryfisher.framework.command.net.NetCommand;
	import maryfisher.framework.command.net.NetRequest;
	import maryfisher.framework.data.NetData;
	import maryfisher.framework.net.INetController;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class NetController {
		
		static private var _instance:NetController;
		private var _netDatas:Dictionary;
		private var _netController:Dictionary;
		
		public function NetController() {
			_netController = new Dictionary();
		}
		
		static private function getInstance():NetController {
			if (!_instance) {
				_instance = new NetController();
				
			}
			return _instance;
		}
		
		static public function init(netDatas:Dictionary, controller:Vector.<INetController>):void {
			getInstance()._netDatas = netDatas;
			for each (var item:INetController in controller) {
				_instance._netController[item.requestType] = item;
			}
		}
		
		static public function registerCommand(cmd:NetCommand):void {
			_instance.netrequest = cmd;
		}
		
		private function set netrequest(cmd:NetCommand):void {
			var data:NetData = _netDatas[cmd.id];
			cmd.buildRequest(data);
			(_netController[data.requestType] as INetController).registerRequest(cmd);
		}
		
		/** TODO
		 * results annehmen, aufsplitten (falls etwas mitgeschickt wurde, das nicht requested wurde
		 */
	}

}