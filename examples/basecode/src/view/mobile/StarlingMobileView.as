package view.mobile {
	import config.ViewConstants;
	import data.GameData;
	import flash.display.BitmapData;
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.view.core.BaseStarlingView;
	import starling.display.Image;
	import starling.textures.Texture;
	import view.interfaces.IGameView;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class StarlingMobileView extends BaseStarlingView implements IGameView {
		
		public function StarlingMobileView() {
			
			
		}
		
		override public function init():void {
			var image:Image = new Image(Texture.fromBitmapData(new BitmapData(200, ViewController.stageHeight, false, 0xffFF)));
			addChild(image);
			
			flatten();
		}
		
		public function set gameData(data:GameData):void {
			
		}
		
		override public function get componentType():String {
			return ViewConstants.GAME_VIEW;
		}
		
	}

}