package config {
	import corset.gifts.config.LoaderConstants;
	import data.StartUpData;
	import flash.utils.Dictionary;
	import maryfisher.framework.config.AbstractConfigureLoaderCommand;
	import maryfisher.framework.data.AssetData;
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
		public static const UI_PATH:String = "assets/ui/";
		public static const XML_PATH:String = "xml/";
		
		private var _startUpData:StartUpData;
		
		public function ConfigureLoaderCommand(startUpData:StartUpData) {
			super();
			_startUpData = startUpData;
			
		}
		
		override protected function getMapping():Dictionary {
			
			if (_startUpData.isMobile) {
				mobileMapping
			}else if (_startUpData.useStarling) {
				starlingMapping();
			}else {
				browserMapping();
			}
			
			return _mapping;
		}
		
		private function mobileMapping():void {
			
			map(LoaderConstants.GAME_VIEW, Away3DMobileView);
			map(LoaderConstants.GAME_VIEW_3D, StarlingMobileView);
		}
		
		private function starlingMapping():void {
			map(LoaderConstants.GAME_VIEW_3D, Away3DBrowserView);
			map(LoaderConstants.GAME_VIEW, StarlingBrowserView);
		}
		
		private function browserMapping():void {
			map(LoaderConstants.GAME_VIEW_3D, Away3DBrowserView);
			map(LoaderConstants.GAME_VIEW, SpriteBrowserView);
		}
		
		private function map(id:String, cl:Class, cache:Boolean = false):void {
			_mapping[id] = new AssetData(cl, cache);
		}
	}

}