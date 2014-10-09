package maryfisher.framework.core {
	import flash.utils.Dictionary;
	import maryfisher.framework.command.net.NetCommand;
	import maryfisher.framework.data.NetData;
	import maryfisher.framework.net.INetController;
	
	/**
	 * Core class for all things backend related. 
	 * It functions as a gateway for diverse INetController so that NetCommands can be send platform independent 
	 * from anywhere inside the application.
	 * @author mary_fisher
	 */
	
	/** TODO
	 * split results if something was sent that was not requested
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
				_instance._netController[item.controllerID] = item;
			}
		}
		
		static public function registerCommand(cmd:NetCommand):void {
            if (!_instance) {
                trace("[NetController] registerCommand - no instance of NetController available! Trying to send request with id:", cmd.id);
                return;
            }
			_instance.netrequest = cmd;
		}
		
		private function set netrequest(cmd:NetCommand):void {
			var data:NetData = _netDatas[cmd.id];
			cmd.buildRequest(data);
			if (!data) {
				return;
			}
			(_netController[data.controllerId] as INetController).registerRequest(cmd);
		}
		
		
	}

}