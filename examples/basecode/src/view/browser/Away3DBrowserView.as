package view.browser {
	import config.ViewConstants;
	import maryfisher.framework.view.core.BaseContainer3DView;
	import maryfisher.framework.view.IViewComponent;
	import view.interfaces.IGameView3D;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Away3DBrowserView extends BaseContainer3DView implements IGameView3D {
		
		public function Away3DBrowserView() {
			
		}
		
		override public function get componentType():String {
			return ViewConstants.GAME_VIEW_3D;
		}
	}

}