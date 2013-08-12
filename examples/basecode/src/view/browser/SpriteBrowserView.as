package view.browser {
	import config.ViewConstants;
	import data.GameData;
	import flash.display.Sprite;
	import maryfisher.framework.view.core.BaseSpriteView;
	import view.interfaces.IGameView;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SpriteBrowserView extends BaseSpriteView implements IGameView {
		
		public function SpriteBrowserView() {
			
		}
		
		public function set gameData(data:GameData):void {
			
		}
		
		override public function get componentType():String {
			return ViewConstants.GAME_VIEW;
		}
		
	}

}