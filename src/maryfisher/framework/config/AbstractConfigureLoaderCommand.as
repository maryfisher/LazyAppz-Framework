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
		protected var _basePath:String = "";
		
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
		 * (don't forget to map your loader paths first @see mapLoaderPaths, then map the LoaderData @see mapLoaderData )
		 * NOTE: the seperation is to facilitate easier use of different loading paths (for different platforms for example)
		 *  
		 * Example: 
		 * 		override protected function getLoaderPaths():void {
		 *			mapLoaderPaths(AssetConstants.EXAMPLE_VIEW, VIEW_PATH + "ExampleView");
		 *			mapLoaderData(AssetConstants.EXAMPLE_VIEW, "Loading Example ...");
		 * 		} 
		 */
		protected function getLoaderPaths():void {	}
		
		/**
		 * override this method to set your asset classes
		 * 
		 * Example: 
		 * 		override protected function getAssetMapping():void {
		 * 			mapAssetData(AssetConstants.EXAMPLE_VIEW, ExampleView);
		 * 		}
		 */
		protected function getAssetMapping():void {	}
		
		/**
		 * map loader id to asset class
		 * 
		 * this method is 
		 * A) for instantiated assets that are compiled with the main application
		 * B) for assets that need to be loaded with specific LoaderCommands (eg sounds => SoundLoaderCommand)
		 * @param	id
		 * @param	assetClass speficies either the class that is to be instantiated or the LoaderCommand class
		 * @param	load specifies if the assetClass is to be instantiated as the asset or if it classifies a LoaderCommand class
		 * @param	doCache specifies if an instance of the class is to be cached for later reuse
		 */
		final protected function mapAssetData(id:String, assetClass:Class, load:Boolean = false, doCache:Boolean = false):void {
			_mapping[id] = new AssetData(assetClass, doCache, load);
		}
		
		/**
		 * map loader id to asset id
		 * 
		 * this method is for to-be-loaded assets 
		 * (classes are not compiled with the main application but are loaded at runtime)
		 * 
		 * @param	id
		 * @param	description
		 * @param	cacheClass specifies if the loaded class is to be cached
		 * @param	reuse specifies if an instance of the loaded is to be cached for later reuse
		 */
		final protected function mapLoaderData(id:String, description:String=null, cacheClass:Boolean = false, reuse:Boolean = false):void {
			_paths[id] = new LoaderData(_loaderPaths[id], cacheClass, reuse, description);
		}
		
		/**
		 * map your loader id to your loader path
		 * 
		 * @param	id
		 * @param	path
		 */
		final protected function mapLoaderPaths(id:String, path:String):void {
			_loaderPaths[id] = _basePath + path;
		}
	}

}