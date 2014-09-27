package maryfisher.framework.config {
	import flash.utils.Dictionary;
	import maryfisher.framework.core.NetController;
	import maryfisher.framework.data.NetData;
	import maryfisher.framework.net.INetController;
	
	/**
	 * Helper class to set up your backend functionality.
	 * 
	 * Extend this class to configure your requests.
	 * 
	 * @author mary_fisher
	 */
	public class AbstractConfigureNetCommand {
		
		private var _datas:Dictionary;
		
		public function AbstractConfigureNetCommand() {
			
		}
		
		public function execute():void {
			_datas = new Dictionary();
			getNetDatas();
			NetController.init(_datas, getController());
		}
		
		/**
		 * override this method to map your NetDatas
		 * 
		 * Example: addNetData(NetConstants.EXAMPLE, NetRequest.TYPE_SQLLITE, "exampleDBID", ExampleRequest);
		 */
		protected function getNetDatas():void {	}
		
		/**
		 * override this method to set up your INetControllers
		 * 
		 * Example: return Vector.<INetController>([new BaseSQLController("examplePath", "exampleDBName", "exampleDBID")])
		 *
		 * @return
		 */
		protected function getController():Vector.<INetController> {
			return Vector.<INetController>([]);
		}
		
		/**
		 * map NetRequest classes to net ids
		 * 
		 * @param	id
		 * @param	format eg: NetRequest.TYPE_JSON
		 * @param	controllerId
		 * @param	netClass
		 */
		final protected function addNetData(id:String, controllerId:String, netClass:Class):void {
			_datas[id] = new NetData(id, controllerId, netClass);
		}
	}

}