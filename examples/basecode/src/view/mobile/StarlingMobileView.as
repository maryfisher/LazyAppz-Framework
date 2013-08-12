package view.mobile {
	import config.ViewConstants;
	import data.GameData;
	import maryfisher.framework.view.core.BaseStarlingView;
	import view.interfaces.IGameView;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class StarlingMobileView extends BaseStarlingView implements IGameView {
		
		public function StarlingMobileView() {
			
			
		}
		
		public function set gameData(data:GameData):void {
			
		}
		
		override public function get componentType():String {
			return ViewConstants.GAME_VIEW;
		}
		
	}

}