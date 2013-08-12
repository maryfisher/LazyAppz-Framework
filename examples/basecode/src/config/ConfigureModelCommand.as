package config {
	import data.GameModel;
	import data.IGameProxy;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import maryfisher.framework.command.AbstractCommand;
	import maryfisher.framework.core.ModelController;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ConfigureModelCommand extends AbstractCommand {
		
		public function ConfigureModelCommand() {
			super();
			
		}
		
		override public function execute():void {
			ModelController.init(getModels());
			
			//new NetCommand(NetConstants.SET_UP, null);
			
			ModelController.initModels();
		}
		
		protected function getModels():Dictionary {
			var models:Dictionary = new Dictionary();
			
			models[getQualifiedClassName(IGameProxy)] = new GameModel();
			
			return models;
		}
	}

}