package maryfisher.framework.core {
	import maryfisher.framework.data.KeyComboData;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IKeyListener {
		function handleKeyDownOnce(key:int):void;
		function handleKeyDown(key:int):void;
		function handleKeyUp(key:int):void;		
		function handleKeyCombo(keyComboData:KeyComboData):void;
	}
	
}