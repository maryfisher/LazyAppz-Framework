package maryfisher.framework.view.core {
	import away3d.core.managers.Stage3DProxy;
	import maryfisher.framework.core.IViewController;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IProxyController extends IViewController{
		function setUpProxy(stage3DProxy:Stage3DProxy):void
	}
	
}