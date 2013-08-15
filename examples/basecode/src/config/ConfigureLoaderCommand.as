package config {
	import data.StartUpData;
	import flash.utils.Dictionary;
	import maryfisher.framework.config.AbstractConfigureLoaderCommand;
	import maryfisher.framework.data.AssetData;
	import maryfisher.framework.data.LoaderData;
	import view.browser.Away3DBrowserView;
	import view.browser.SpriteBrowserView;
	import view.browser.StarlingBrowserView;
	import view.mobile.Away3DMobileView;
	import view.mobile.StarlingMobileView;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ConfigureLoaderCommand extends AbstractConfigureLoaderCommand {
		
		public static const VIEW_PATH:String = "assets/";
		
		public function ConfigureLoaderCommand() {
			super();
		}
		
		override protected function getMapping():Dictionary {
			/************ 
			 * NOTE
			 * 
			 * instead of using CONFIG definitions you can extend the class and overriding this method 
			 * in the respective projects
			 */
			
			CONFIG::mobile {
				map(LoaderConstants.GAME_VIEW_3D, Away3DMobileView);
				map(LoaderConstants.GAME_VIEW, StarlingMobileView);
			} 
			//CONFIG::desktop {
				//map(LoaderConstants.GAME_VIEW_3D, Away3DBrowserView);
				//map(LoaderConstants.GAME_VIEW, StarlingBrowserView);
			//}
			CONFIG::browser {
				map(LoaderConstants.GAME_VIEW_3D, Away3DBrowserView);
				map(LoaderConstants.GAME_VIEW, StarlingBrowserView);
			}
			
			return _mapping;
		}
		
		override protected function getLoaderPaths():Dictionary {
			
			_loaderPaths = new Dictionary();
			_paths = new Dictionary();
			
			CONFIG::desktop {
				_loaderPaths[LoaderConstants.GAME_VIEW] = VIEW_PATH + "GameView";
				_loaderPaths[LoaderConstants.GAME_VIEW_3D] = VIEW_PATH + "GameView3D";
				
				addLoaderData(LoaderConstants.GAME_VIEW, "", true);
				addLoaderData(LoaderConstants.GAME_VIEW_3D, "");
			}
			return _paths;
		}
	}

}