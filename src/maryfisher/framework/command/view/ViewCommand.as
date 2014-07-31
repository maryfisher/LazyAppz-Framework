package maryfisher.framework.command.view {
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.view.IViewComponent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ViewCommand {
		
		public static const REGISTER_VIEW:String = 'registerView';
		static public const UNREGISTER_VIEW:String = 'unregisterView';
		
		static public const SWITCH_MOUSE:String = "registerMouse";
		
		public static const TOGGLE_FULL_SCREEN:String = 'toggleFullScreen';
		public static const PAUSE:String = 'pause';
		public static const CONTINUE:String = 'continue';
		
		static public const ADD_VIEW:String = 'addView';
		static public const REMOVE_VIEW:String = 'removeView';
		
		//static public const TO_TOP_VIEW:String = 'toTopView';
		//static public const TO_BOTTOM_VIEW:String = 'toBottomView';
		
		protected var _view:IViewComponent;
		protected var _viewCommandType:String;
		protected var _viewType:String;
		
		public function ViewCommand(tview:IViewComponent = null, viewCommandType:String = ADD_VIEW, viewType:String = null) {

			_viewType = viewType;
			_viewCommandType = viewCommandType;
			_view = tview;
			execute();
		}
		
		protected function execute():void {
			ViewController.registerCommand(this);
		}
		
		public function get view():IViewComponent { return _view; }
		
		public function get viewCommandType():String {
			return _viewCommandType;
		}
		
		public function get viewType():String {
			if (view) {
				return view.componentType;
			}
			return _viewType;
		}
	}
}