package maryfisher.framework.view {
	
	
	public interface ILoaderView extends IViewComponent {
		function show():void;
		function hide():void;
		function changePercent(percent:Number):void;
	}
}