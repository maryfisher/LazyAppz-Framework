package maryfisher.framework.command.loader {
	import controller.command.global.loader.LoaderCommand;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ILoadingCallback {
		function loadingFinished(cmd:LoaderCommand):void;
	}
	
}