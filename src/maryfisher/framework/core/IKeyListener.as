package maryfisher.framework.core {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IKeyListener {
		function handleKeyDownOnce(key:int):void;
		function handleKeyDown(key:int):void;
		function handleKeyUp(key:int):void;		
		function handleKeyCombo():void;
	}
	
}