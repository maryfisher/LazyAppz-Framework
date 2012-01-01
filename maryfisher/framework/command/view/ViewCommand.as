package maryfisher.framework.command.view {
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.view.IViewComponent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ViewCommand {
		
		public static const TOGGLE_FULL_SCREEN:String = 'toggleFullScreen';
		static public const ADD_VIEW:String = 'addView';
		static public const REMOVE_VIEW:String = 'removeView';
		public static const PAUSE:String = "pause";
		public static const CONTINUE:String = "continue";
		static public const TO_TOP_VIEW:String = 'toTopView';
		static public const TO_BOTTOM_VIEW:String = 'toBottomView';
		
		protected var _view:IViewComponent;
		protected var _viewCommandType:String;
		
		public function ViewCommand(tview:IViewComponent = null, viewCommandType:String = ADD_VIEW) {
			_viewCommandType = viewCommandType;
			_view = tview;
			execute();
		}
		
		private function execute():void {
			ViewController.registerCommand(this);
		}
		
		public function get view():IViewComponent { return _view; }
		
		public function get viewCommandType():String {
			return _viewCommandType;
		}
		
	}
}