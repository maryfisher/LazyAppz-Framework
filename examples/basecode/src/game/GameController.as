package game {
	import config.LoaderConstants;
	import data.GameModel;
	import data.IGameProxy;
	import maryfisher.framework.command.asset.IAssetCallback;
	import maryfisher.framework.command.asset.LoadAssetCommand;
	import maryfisher.framework.model.AbstractProxy;
	import view.interfaces.IGameView;
	import view.interfaces.IGameView3D;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class GameController extends AbstractProxy implements IGameProxy, IAssetCallback{
		
		private var _gameView:IGameView;
		private var _gameView3D:IGameView3D;
		
		private var _gameModel:GameModel;
		
		public function GameController() {
			super();
		}
		
		override protected function onModelsLoaded():void {
			new LoadAssetCommand(LoaderConstants.GAME_VIEW, this);
		}
		
		/* INTERFACE maryfisher.framework.command.asset.IAssetCallback */
		
		public function assetFinished(cmd:LoadAssetCommand):void {
			if (cmd.id == LoaderConstants.GAME_VIEW) {
				_gameView = cmd.viewComponent as IGameView;
				_gameView.gameData = _gameModel.gameData;
				_gameView.addView();
				
				new LoadAssetCommand(LoaderConstants.GAME_VIEW_3D, this, "", false, "");
				
			}else if (cmd.id == LoaderConstants.GAME_VIEW_3D) {
				_gameView3D = cmd.viewComponent as IGameView3D;
				_gameView3D.addView();
			}
		}
		
		/* INTERFACE data.IGameProxy */
		
		public function set gameModel(value:GameModel):void { _gameModel = value; }
		
	}

}