package maryfisher.framework.core {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IKeyListener {
		function handleKeyDownOnce(key:String):void;
		function handleKeyDown(key:String):void;
		function handleKeyUp(key:String):void;		
		function handleKeyCombo():void;
	}
	
}