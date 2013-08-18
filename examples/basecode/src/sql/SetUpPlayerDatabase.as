package sql {
	import config.SQLTableConstants;
	import flash.events.SQLEvent;
	import maryfisher.framework.command.net.SQLRequest;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SetUpPlayerDatabase extends SQLRequest {
		
		public function SetUpPlayerDatabase() {
			
		}
		
		override protected function onDatabaseOpen(e:SQLEvent):void {
			super.onDatabaseOpen(e);
				
			createTable(SQLTableConstants.PLAYER_GAME_DATA, 
				[	"id", 								"playerName"], 
				[INTEGER + PRIMARY_KEY + AUTOINCREMENT, TEXT]);
		}
		
		override protected function onCreate(e:SQLEvent):void {
			super.onCreate(e);
			
			finishRequest(null);
		}
	}

}