package {
	import data.StartUpData;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Main extends Sprite {
		
		private var _startUp:StartUp;
		
		public function Main():void {
			_startUp = new StartUp();
			_startUp.init(stage, new StartUpData(true, false));
		}
		
	}
	
}