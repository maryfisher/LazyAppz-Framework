package config {
	import flash.utils.Dictionary;
	import maryfisher.framework.command.net.NetRequest;
	import maryfisher.framework.core.NetController;
	import maryfisher.framework.data.NetData;
	import maryfisher.framework.net.BaseJSONController;
	import maryfisher.framework.net.BaseSQLController;
	import maryfisher.framework.net.BaseXMLController;
	import maryfisher.framework.net.INetController;
	import net.GetJSONConfigData;
	import net.GetJSONPlayerData;
	import sql.GetSQLConfigData;
	import sql.GetSQLPlayerData;
	import sql.SetUpConfigDatabase;
	import sql.SetUpPlayerDatabase;
	import xml.GetXMLConfigData;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ConfigureNetCommand {
		
		static private const CONFIG_DATABASE:String = "configDatabase";
		static private const PLAYER_DATABASE:String = "playerDatabase";
		
		private var _datas:Dictionary;
		
		public function ConfigureNetCommand() {
			super();
			
		}
		
		/**
		 * <p>this will create a directory FrameworkTest and two database in your users documents directory. For more 
		 * details see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/filesystem/File.html#documentsDirectory </p>
		 */
		public function execute():void {
			
			var sqllitePath:String = "/FrameworkTest";
			var configDB:String = "config";
			var playerDB:String = "player";
			var hostPath:String = "http://localhost/FrameworkTest/";
			var xmlPath:String = "xml/";
				
			CONFIG::desktop {
				
				NetController.init(getNetDatas(), Vector.<INetController>([
					new BaseSQLController(sqllitePath, configDB, CONFIG_DATABASE),
					new BaseSQLController(sqllitePath, playerDB, PLAYER_DATABASE)
					]));
			}
			
			CONFIG::browser {
				NetController.init(getNetDatas(), Vector.<INetController>([
					new BaseJSONController(hostPath, getJSONUrls(), PLAYER_DATABASE)
					]));
			}
			
			CONFIG::mobile {
				NetController.init(getNetDatas(), Vector.<INetController>([
					new BaseXMLController(xmlPath, CONFIG_DATABASE),
					new BaseJSONController(hostPath, getJSONUrls(), PLAYER_DATABASE)
					]));
			}
		}
		
		private function getJSONUrls():Dictionary {
			var urls:Dictionary = new Dictionary();
			urls[NetConstants.GET_CONFIG_DATA] = "getConfigData.php";
			urls[NetConstants.GET_PLAYER_DATA] = "getPlayerData.php";
			
			return urls;
		}
		
		private function getXMLUrls():Dictionary {
			var urls:Dictionary = new Dictionary();
			urls[NetConstants.GET_CONFIG_DATA] = "config.xml";
			urls[NetConstants.GET_PLAYER_DATA] = "player.xml";
			
			return urls;
		}
		
		private function getNetDatas():Dictionary {
			_datas = new Dictionary();
			
			CONFIG::desktop {
				addData(NetConstants.SET_UP_CONFIGS, NetRequest.TYPE_SQLLITE, CONFIG_DATABASE, SetUpConfigDatabase);
				addData(NetConstants.SET_UP_PLAYER, NetRequest.TYPE_SQLLITE, PLAYER_DATABASE, SetUpPlayerDatabase);
				addData(NetConstants.GET_CONFIG_DATA, NetRequest.TYPE_SQLLITE, CONFIG_DATABASE, GetSQLConfigData);
				addData(NetConstants.GET_PLAYER_DATA, NetRequest.TYPE_SQLLITE, PLAYER_DATABASE, GetSQLPlayerData);
			}
			CONFIG::browser {
				addData(NetConstants.GET_CONFIG_DATA, NetRequest.TYPE_JSON, PLAYER_DATABASE, GetJSONConfigData);
				addData(NetConstants.GET_PLAYER_DATA, NetRequest.TYPE_JSON, PLAYER_DATABASE, GetJSONPlayerData);
			}
			
			CONFIG::mobile {
				addData(NetConstants.GET_CONFIG_DATA, NetRequest.TYPE_XML, CONFIG_DATABASE, GetXMLConfigData);
				addData(NetConstants.GET_PLAYER_DATA, NetRequest.TYPE_JSON, PLAYER_DATABASE, GetJSONPlayerData);
			}
			
			return _datas;
		}
		
		private function addData(id:String, format:String, controller:String, cl:Class):void {
			_datas[id] = new NetData(id, format, controller, cl);
		}
	}

}