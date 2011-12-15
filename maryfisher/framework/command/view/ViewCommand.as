package maryfisher.framework.command.view {
	import controller.command.global.GlobalCommand;
	import model.data.global.LoaderData;
	import view.core.IGlobalView;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ViewCommand extends GlobalCommand {
		
		static public const ADD_VIEW:String = 'addView';
		static public const REMOVE_VIEW:String = 'removeView';
		static public const TO_TOP_VIEW:String = 'toTopView';
		static public const TO_BOTTOM_VIEW:String = 'toBottomView';
		
		protected var _doAdd:Boolean;
		protected var _view:IGlobalView;
		protected var _viewCommandType:String;
		
		public function ViewCommand(tview:IGlobalView = null, viewCommandType:String = ADD_VIEW) {
			_viewCommandType = viewCommandType;
			_doAdd = viewCommandType == ADD_VIEW;
			_view = tview;
			execute();
		}
		
		public function get view():IGlobalView { return _view; }
		public function set view(value:IGlobalView):void { _view = value; }
		
		public function get doAdd():Boolean { return _doAdd; }
		
	}
}