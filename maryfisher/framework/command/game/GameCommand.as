package maryfisher.framework.command.game {
	import controller.command.global.GlobalCommand;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class GameCommand extends GlobalCommand {
		
		static public const PAUSE_GAME:String = "pauseGame";
		static public const SAVE_GAME:String = "saveGame";
		static public const NEW_GAME:String = "newGame";
		static public const LOAD_GAME:String = "loadGame";
		
		private var _commandType:String;
		
		public function GameCommand(commandType:String) {
			_commandType = commandType;
			execute();
		}
		
	}

}