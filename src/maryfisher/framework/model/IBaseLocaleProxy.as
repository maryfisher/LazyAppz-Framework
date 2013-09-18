package maryfisher.framework.model {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IBaseLocaleProxy {
		function set localeModel(value:BaseLocaleModel):void;
		function onLanguageChanced(update:BaseLocaleUpdate):void;
	}
	
}