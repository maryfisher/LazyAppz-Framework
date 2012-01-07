package maryfisher.framework.view.controller {
	import flash.display.Stage;
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.view.IViewComponent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IViewController {
		function addView(view:IViewComponent):void;
		function removeView(view:IViewComponent):void;
		function setUp(stage:Stage, controller:ViewController):void
		function pauseView():void;
		function continueView():void;
	}
	
}