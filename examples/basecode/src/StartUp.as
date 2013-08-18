package {
	import config.ConfigureLoaderCommand;
	import config.ConfigureModelCommand;
	import config.ConfigureNetCommand;
	import config.ConfigureViewCommand;
	import config.NetConstants;
	import data.StartUpData;
	import flash.display.Stage;
	import game.GameController;
	import maryfisher.framework.command.net.INetRequestCallback;
	import maryfisher.framework.command.net.NetCommand;
	import maryfisher.framework.core.ViewController;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class StartUp implements INetRequestCallback {
		
		private var _gameController:GameController;
		
		public function StartUp() {
		
		}
		
		public function init(stage:Stage):void {
			
			/**
			 * to experiment with configurations please read README.txt first
			 */
			new ConfigureLoaderCommand().execute();
			new ConfigureViewCommand().execute(stage);
			//new ConfigureNetCommand().execute();
			new ConfigureModelCommand().execute();
			
			ViewController.onFinished(onFinished);
		}
		
		private function onFinished():void {
			_gameController = new GameController();
			//runSetup();
		}
		
		private function runSetup():void {
			new NetCommand(NetConstants.SET_UP_CONFIGS, null, this);
		}
		
		/* INTERFACE maryfisher.framework.command.net.INetRequestCallback */
		
		public function onRequestReceived(cmd:NetCommand):void {
			if (cmd.id == NetConstants.SET_UP_CONFIGS) {
				new NetCommand(NetConstants.SET_UP_PLAYER, null, this);
				return;
			}
			_gameController = new GameController();
		}
	}

}