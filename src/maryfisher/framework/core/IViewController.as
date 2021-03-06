package maryfisher.framework.core {
	import flash.display.Stage;
	import maryfisher.framework.command.view.ViewCommand;
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
		
		function registerView(view:IViewComponent):void;
		function unRegisterView(view:IViewComponent):void;
		
		function registerCommand(viewCommand:ViewCommand):void;
		
		function render():void;
		
		function get controllerId():String;
	}
	
}