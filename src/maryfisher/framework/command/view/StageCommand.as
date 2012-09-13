package maryfisher.framework.command.view {
	import maryfisher.framework.core.ViewController;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class StageCommand {
		
		public static const REGISTER_TICK:String = 'registerTick';
		static public const UNREGISTER_TICK:String = 'unregisterTick';
		public static const REGISTER_MOUSE:String = 'registerMouse';
		static public const UNREGISTER_MOUSE:String = 'unregisterMouse';
		public static const REGISTER_RESIZE:String = 'registerResize';
		static public const UNREGISTER_RESIZE:String = 'unregisterResize';
		
		public var obj:*;
		public var commandType:String;
		
		
		public function StageCommand(commandType:String, obj:*) {
			this.commandType = commandType;
			this.obj = obj;
			
			execute();
		}
		
		protected function execute():void {
			ViewController.registerStageCommand(this);
		}
	}

}