package sql {
	import config.SQLTableConstants;
	import flash.events.SQLEvent;
	import maryfisher.framework.command.net.SQLRequest;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SetUpConfigDatabase extends SQLRequest {
		
		public function SetUpConfigDatabase() {
			
		}
		
		override protected function onDatabaseOpen(e:SQLEvent):void {
			super.onDatabaseOpen(e);
			
			createTable(SQLTableConstants.CONFIG_GAME_DATA, 
				[	"id", 								"info"], 
				[INTEGER + PRIMARY_KEY + AUTOINCREMENT, TEXT]);
		}
		
		override protected function onCreate(e:SQLEvent):void {
			super.onCreate(e);
			
			finishRequest(null);
		}
	}

}