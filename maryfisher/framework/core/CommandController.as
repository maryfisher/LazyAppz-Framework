package maryfisher.framework.core {
	
	import maryfisher.framework.command.game.GameCommand;
	import maryfisher.framework.command.game.IGameCommandReceiver;
	import maryfisher.framework.command.GlobalCommand;
	import maryfisher.framework.command.INetCommandReceiver;
	import maryfisher.framework.command.loader.ILoaderCommandReceiver;
	import maryfisher.framework.command.loader.LoaderCommand;
	import maryfisher.framework.command.NetCommand;
	import maryfisher.framework.command.view.IViewCommandReceiver;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.core.ModelController;
	
	import flash.utils.Dictionary;
	
	
	/**
	 * wie NotificationManager, nur mit Commands - Commands registrieren sich selbst
	 * zB: SaveCommand wird vom Menu aus gesendet, ModelController führt ihn aus, ViewController registriert sich dafür, andere Aktionen, die angehalten werden wollen
	 * ViewCommands - zB 3D möchte wissen, wann Window geöffnet und wann geschlossen wird
	 * @author mary_fisher
	 */
	public class CommandController{
		
		private static var _commandReceiver:Dictionary; /* Class => Vector.<CommandReceriver> */
		private static var _loaderCommandReceiver:Vector.<ILoaderCommandReceiver>;
		private static var _viewCommandReceiver:Vector.<IViewCommandReceiver>;
		private static var _netCommandReceiver:Vector.<INetCommandReceiver>;
		private static var _gameCommandReceiver:Vector.<IGameCommandReceiver>;
		
		public function CommandController() {
			
		}
		
		public function init():void {
			_loaderCommandReceiver = new Vector.<ILoaderCommandReceiver>();
			_viewCommandReceiver = new Vector.<IViewCommandReceiver>();
			_netCommandReceiver = new Vector.<INetCommandReceiver>();
			_gameCommandReceiver = new Vector.<IGameCommandReceiver>();
			//_commandReceiver = new Dictionary();
			//_commandReceiver[LoaderCommand] = _loaderCommandReceiver;
			//_commandReceiver[SimpleViewCommand] = _viewCommandReceiver;
			//_commandReceiver[NetCommand] = _loaderCommandReceiver;
			//_commandReceiver[GameCommand] = _loaderCommandReceiver;
		}
		
		static public function registerCommand(globalCommand:GlobalCommand):void{
			if (globalCommand is ViewCommand) {
				for each(var receiver:IViewCommandReceiver in _viewCommandReceiver) {
					//trace('fucking view command ', receiver, (globalCommand as ViewCommand).view);
					receiver.viewCommand = globalCommand as ViewCommand;
				}
			}else if (globalCommand is LoaderCommand) {
				for each(var lreceiver:ILoaderCommandReceiver in _loaderCommandReceiver) {
					lreceiver.loaderCommand = globalCommand as LoaderCommand;
				}
			}else if (globalCommand is GameCommand) {
				for each(var greceiver:IGameCommandReceiver in _gameCommandReceiver) {
					greceiver.gameCommand = globalCommand as GameCommand;
				}
			}
		}
		
		public function registerForLoaderCommand(receiver:ILoaderCommandReceiver):void{
			_loaderCommandReceiver.push(receiver);
		}
		
		public function registerForGameCommand(receiver:IGameCommandReceiver):void {
			_gameCommandReceiver.push(receiver);
		}
		
		public function registerForViewCommand(receiver:IViewCommandReceiver):void {
			_viewCommandReceiver.push(receiver);
		}
	}
}