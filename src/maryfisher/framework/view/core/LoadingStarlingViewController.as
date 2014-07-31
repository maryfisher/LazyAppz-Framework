package maryfisher.framework.view.core {
	import maryfisher.framework.view.ILoaderView;
	import maryfisher.framework.view.IStarlingView;
	import maryfisher.framework.view.IViewComponent;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LoadingStarlingViewController extends LoadingViewController {
		
		protected var _starling:Starling;
		protected var _hasContext:Boolean;
		protected var _container:starling.display.Sprite;
		private var _starlingController:IStarlingController;
		
		public function LoadingStarlingViewController(starlingController:IStarlingController) {
			super();
			_container = new Sprite();
			_starlingController = starlingController;
			_starlingController.onFinished.addOnce(onContectCreated);
		}
		
		private function onContectCreated(starling:Starling):void {
			_starling = starling;
			_starling.stage.addChild(_container);
			//_hasContext = true;
			initComps();
		}
		
		override public function addView(view:IViewComponent):void {
			_loadingView = view as ILoaderView;
			_container.addChild(view as DisplayObject);
			if (_hasContext) (view as IStarlingView).init();
		}
		
		override public function removeView(view:IViewComponent):void {
			_container.removeChild(view as DisplayObject);
		}
		
		protected function initComps():void {
			for (var i:int = 0; i < _container.numChildren; i++) {
				var sv:IStarlingView = (_container.getChildAt(i) as IStarlingView);
				if (!sv) continue;
				sv.init();
			}
			_hasContext = true;
		}
	}

}