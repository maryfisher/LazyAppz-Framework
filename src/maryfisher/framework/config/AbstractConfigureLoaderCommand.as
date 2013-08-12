package maryfisher.framework.config {
	import flash.utils.Dictionary;
	import maryfisher.framework.command.AbstractCommand;
	import maryfisher.framework.core.AssetController;
	import maryfisher.framework.core.LoaderController;
	import maryfisher.framework.data.LoaderData;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractConfigureLoaderCommand extends AbstractCommand {
		
		protected var _mapping:Dictionary;
		protected var _loaderPaths:Dictionary;
		protected var _paths:Dictionary;
		
		public function AbstractConfigureLoaderCommand() {
			super();
			_loaderPaths = new Dictionary();
		}
		
		override public function execute():void {
			
			_paths = new Dictionary();
			_mapping = new Dictionary();
			
			AssetController.init(getLoaderPaths(), getMapping());
		}
		
		protected function getLoaderPaths():Dictionary {
			return _paths;
		}
		
		protected function getMapping():Dictionary {
			return _mapping;
		}
		
		private function addLoaderData(id:String, description:String=null, doCache:Boolean = false, reuse:Boolean = false):void {
			_paths[id] = new LoaderData(_loaderPaths[id], doCache, reuse, description);
		}
	}

}