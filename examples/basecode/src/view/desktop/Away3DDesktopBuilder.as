package view.desktop {
	import flash.display.Sprite;
	import maryfisher.framework.view.IAssetBuilder;
	import maryfisher.framework.view.IViewComponent;
	import view.browser.Away3DBrowserView;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Away3DDesktopBuilder extends Sprite implements IAssetBuilder {
		
		public function Away3DDesktopBuilder() {
			
		}
		
		/* INTERFACE maryfisher.framework.view.IAssetBuilder */
		
		public function getViewComponent(id:String):IViewComponent {
			return new Away3DBrowserView();
		}
		
	}

}