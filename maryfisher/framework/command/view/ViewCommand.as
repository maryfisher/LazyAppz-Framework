package maryfisher.framework.command.view {
	import maryfisher.framework.command.AbstractCommand;
	import maryfisher.framework.view.IViewComponent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ViewCommand extends AbstractCommand {
		
		static public const ADD_VIEW:String = 'addView';
		static public const REMOVE_VIEW:String = 'removeView';
		static public const TO_TOP_VIEW:String = 'toTopView';
		static public const TO_BOTTOM_VIEW:String = 'toBottomView';
		
		protected var _doAdd:Boolean;
		protected var _view:IViewComponent;
		protected var _viewCommandType:String;
		
		public function ViewCommand(tview:IViewComponent = null, viewCommandType:String = ADD_VIEW) {
			_viewCommandType = viewCommandType;
			_doAdd = viewCommandType == ADD_VIEW;
			_view = tview;
			execute();
		}
		
		public function get view():IViewComponent { return _view; }
		public function set view(value:IViewComponent):void { _view = value; }
		
		public function get doAdd():Boolean { return _doAdd; }
		
	}
}