package maryfisher.framework.core {
	import flash.utils.Dictionary;
	import maryfisher.framework.view.IBlittingComponent;
	import maryfisher.framework.view.IViewComponent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ViewController {
		
		public static const SPRITE:String = "sprite";
		
		private var _regViewComps:Vector.<IViewComponent>;
		private var _coloredComps:Dictionary; /* hitColor => IBlittingComponent */
		private var _lastHitColor:uint;
		private var _hitColorPool:Vector.<uint>;
		private var _blittingComps:Vector.<IBlittingComponent>;
		
		public function ViewController() {
			
		}
		
	}

}