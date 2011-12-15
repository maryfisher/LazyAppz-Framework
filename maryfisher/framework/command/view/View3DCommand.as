package maryfisher.framework.command.view {
	import away3d.containers.ObjectContainer3D;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class View3DCommand extends SimpleViewCommand {
		private var _view:ObjectContainer3D;
		
		public function View3DCommand(view:ObjectContainer3D, viewCommandType:String) {
			super(viewCommandType);
			_view = view;
			
		}
		
		public function get view():ObjectContainer3D { return _view; }
		
	}

}