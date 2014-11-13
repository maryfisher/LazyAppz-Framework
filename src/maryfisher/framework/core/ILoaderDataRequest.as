package maryfisher.framework.core {
	import maryfisher.framework.data.LoaderData;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ILoaderDataRequest {
		function get loaderDataId():String;
		function set loaderData(value:LoaderData):void;
	}
	
}