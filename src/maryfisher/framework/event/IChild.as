package maryfisher.framework.event {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IChild {
		function get parent():IParent;
		function set parent(value:IParent):void;
	}
	
}