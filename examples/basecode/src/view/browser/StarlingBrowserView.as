package view.browser {
	import config.ViewConstants;
	import data.GameData;
	import maryfisher.framework.view.core.BaseStarlingView;
	import view.interfaces.IGameView;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class StarlingBrowserView extends BaseStarlingView implements IGameView {
		
		public function StarlingBrowserView() {
			
		}
		
		public function set gameData(data:GameData):void {
			
		}
		
		override public function get componentType():String {
			return ViewConstants.GAME_VIEW;
		}
		
	}

}