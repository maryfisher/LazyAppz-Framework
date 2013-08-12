package view.interfaces {
	import data.GameData;
	import maryfisher.framework.view.IViewComponent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IGameView extends IViewComponent {
		function set gameData(data:GameData):void;
	}
	
}