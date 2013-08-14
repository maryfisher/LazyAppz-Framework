package config {
	import data.StartUpData;
	import flash.utils.Dictionary;
	import maryfisher.framework.core.NetController;
	import maryfisher.framework.data.NetData;
	import maryfisher.framework.net.BaseSQLController;
	import maryfisher.framework.net.INetController;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ConfigureNetCommand {
		private var _datas:Dictionary;
		
		public function ConfigureNetCommand() {
			super();
			
		}
		
		public function execute(startUpData:StartUpData):void {
			
			CONFIG::desktop{
				NetController.init(getNetDatas(), Vector.<INetController>([
					new BaseSQLController("/FrameworkTest", "config", NetConstants.CONFIG_DATABASE),
					new BaseSQLController("/FrameworkTest", "player", NetConstants.PLAYER_DATABASE)
					]));
			}
		}
		
		private function getNetDatas():Dictionary {
			_datas = new Dictionary();
			
			
			//addData(NetCommandConstants.SET_UP_CONFIGS, "sql", NetConstants.CONFIG_DATABASE, SetUpConfigDatabase);
			
			return _datas;
		}
		
		private function addData(id:String, format:String, controller:String, cl:Class):void {
			_datas[id] = new NetData(id, format, controller, cl);
		}
	}

}