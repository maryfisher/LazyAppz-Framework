package view.desktop {
	import config.ViewConstants;
	import data.GameData;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.view.core.BaseSpriteView;
	import view.interfaces.IGameView;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SpriteDesktopView extends BaseSpriteView implements IGameView {
		
		public function SpriteDesktopView() {
			addChild(new Bitmap(new BitmapData(200, ViewController.stageHeight, false, 0xff00)));
		}
		
		public function set gameData(data:GameData):void {
			
		}
		
		override public function get componentType():String {
			return ViewConstants.GAME_VIEW;
		}
		
	}

}