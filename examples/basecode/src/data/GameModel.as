package data {
	import maryfisher.framework.model.AbstractModel;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class GameModel extends AbstractModel {
		
		private var _gameData:GameData;
		
		public function GameModel() {
			
		}
		
		public function get gameData():GameData {
			return _gameData;
		}
		
	}

}