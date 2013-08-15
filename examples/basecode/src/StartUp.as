package {
	import config.ConfigureLoaderCommand;
	import config.ConfigureModelCommand;
	import config.ConfigureNetCommand;
	import config.ConfigureViewCommand;
	import data.StartUpData;
	import flash.display.Stage;
	import game.GameController;
	import maryfisher.framework.core.ViewController;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class StartUp {
		
		private var _gameController:GameController;
		
		public function StartUp() {
		
		}
		
		public function init(stage:Stage):void {
			
			
			new ConfigureLoaderCommand().execute();
			new ConfigureViewCommand().execute(stage);
			new ConfigureNetCommand().execute();
			new ConfigureModelCommand().execute();
			
			ViewController.onFinished(onFinished);
		}
		
		private function onFinished():void {			
			_gameController = new GameController();
		}
	}

}