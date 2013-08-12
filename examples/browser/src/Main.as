package {
	import data.StartUpData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Main extends Sprite {
		
		private var _startUp:StartUp;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_startUp = new StartUp();
			_startUp.init(stage, new StartUpData(true, false));
		}
		
	}
	
}