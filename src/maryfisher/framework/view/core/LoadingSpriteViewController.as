package maryfisher.framework.view.core {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.view.ILoaderView;
	import maryfisher.framework.view.IViewComponent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LoadingSpriteViewController extends LoadingViewController {
		
		private var _container:Sprite = new Sprite();
		private var _stage:Stage;
		
		public function LoadingSpriteViewController() {
			super();
		}
		
		override public function addView(view:IViewComponent):void {
			if (_loadingView) {
				_container.removeChild(_loadingView as DisplayObject);
			}
			_loadingView = view as ILoaderView;
			_loadingView.hide();
			_container.addChild(_loadingView as DisplayObject);
		}
		
		override public function removeView(view:IViewComponent):void {
			if (_loadingView) {
				_container.removeChild(_loadingView as DisplayObject);
				_loadingView = null;
			}
		}
		
		override public function setUp(stage:Stage, controller:ViewController):void {
			_stage = stage;
			_stage.addChild(_container);
		}
		
		
	}

}