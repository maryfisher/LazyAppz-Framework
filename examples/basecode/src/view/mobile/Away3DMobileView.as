package view.mobile {
	import config.ViewConstants;
	import maryfisher.framework.view.core.BaseContainer3DView;
	import view.interfaces.IGameView3D;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Away3DMobileView extends BaseContainer3DView implements IGameView3D {
		
		public function Away3DMobileView() {
			
		}
		
		override public function get componentType():String {
			return ViewConstants.GAME_VIEW_3D;
		}
		
	}

}