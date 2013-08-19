package maryfisher.framework.config {
	import flash.utils.Dictionary;
	import maryfisher.framework.command.AbstractCommand;
	import maryfisher.framework.core.AssetController;
	import maryfisher.framework.data.AssetData;
	import maryfisher.framework.data.LoaderData;
	
	/**
	 * Helper class to set up assets and loading paths.
	 * 
	 * Extend this class to configure your own set up.
	 * 
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
			
			getLoaderPaths();
			getAssetMapping();
			AssetController.init(_paths, _mapping);
		}
		
		/**
		 * override this methode to set your loader and view ids 
		 * 
		 * (don't forget to map your loader paths first)
		 * NOTE: the seperation is to facilitate easier use of different loading paths (for different platforms eg)
		 *  
		 * Example: 
		 * 		mapLoaderPaths(LoaderConstants.EXAMPLE_VIEW, VIEW_PATH + "ExampleView");
		 * 		mapLoaderData(LoaderConstants.EXAMPLE_VIEW, "Loading Example ...");
		 */
		protected function getLoaderPaths():void {	}
		
		/**
		 * override this method to set your asset classes
		 * 
		 * Example: mapAssetData(LoaderConstants.EXAMPLE_VIEW, ExampleView);
		 */
		protected function getAssetMapping():void {	}
		
		/**
		 * map loader id to view class
		 * 
		 * this method is for instantiated - not loaded! - assets that are compiled with the main application
		 * @param	id
		 * @param	viewClass
		 * @param	doCache
		 */
		final protected function mapAssetData(id:String, viewClass:Class, doCache:Boolean = false):void {
			_mapping[id] = new AssetData(cl, cache);
		}
		
		/**
		 * map loader id to view id
		 * 
		 * this method is for loaded assets 
		 * (classes are not compiled with the main application but are loaded at runtime)
		 * @param	id
		 * @param	description
		 * @param	doCache
		 * @param	reuse
		 */
		final protected function mapLoaderData(id:String, description:String=null, doCache:Boolean = false, reuse:Boolean = false):void {
			_paths[id] = new LoaderData(_loaderPaths[id], doCache, reuse, description);
		}
		
		/**
		 * map your loader id to your loader path
		 * 
		 * @param	id
		 * @param	path
		 */
		final protected function mapLoaderPaths(id:String, path:String):void {
			_loaderPaths[id] = path;
		}
	}

}