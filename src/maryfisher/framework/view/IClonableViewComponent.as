package maryfisher.framework.view {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IClonableViewComponent extends IViewComponent{
		function clone():IViewComponent;
		
		//function addOnFinished(onViewFinished:Function):void;
		//function init(clone:Boolean = false):void;
	}
	
}