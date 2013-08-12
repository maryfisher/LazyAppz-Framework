package {
	import config.ConfigureLoaderCommand;
	import config.ConfigureModelCommand;
	import config.ConfigureNetCommand;
	import config.ConfigureViewCommand;
	import data.StartUpData;
	import flash.display.Stage;
	import game.GameController;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class StartUp {
		
		private var _gameController:GameController;
		
		public function StartUp() {
		
		}
		
		public function init(stage:Stage, startUp:StartUpData):void {
			
			new ConfigureLoaderCommand(startUp).execute();
			new ConfigureViewCommand().execute(stage, startUp);
			new ConfigureNetCommand().execute(startUp);
			new ConfigureModelCommand().execute();
			
			_gameController = new GameController();
		}
	}

}