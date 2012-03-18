package maryfisher.framework.event {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IChild extends IParent{
		function get parent():IParent;
		function set parent(value:IParent):void;
	}
	
}