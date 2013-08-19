package maryfisher.framework.config {
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import maryfisher.framework.core.ModelController;
	
	/**
	 * Helper class to set up model functionality.
	 * 
	 * Extend this class to set up your own configurations.
	 * 
	 * @author mary_fisher
	 */
	public class AbstractConfigureModelCommand {
		
		private var _models:Dictionary;
		
		public function AbstractConfigureModelCommand() {
			_models = new Dictionary();
		}
		
		public function execute():void {
			getModels()
			ModelController.init(_models);
			runNetSetup();
			ModelController.initModels();
		}
		
		/**
		 * this is for NetCommands that set up databases
		 */
		protected function runNetSetup():void {
			
		}
		
		/**
		 * map your proxy interfaces to your models here
		 * 
		 * Example: mapModels(IExampleProxy, ExampleModel);
		 * @return
		 */
		protected function getModels():void { }
		
		final protected function mapModel(proxy:Class, model:Class):void {
			_models[getQualifiedClassName(proxy)] = new model();
		}
	}

}