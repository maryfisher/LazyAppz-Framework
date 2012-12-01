package maryfisher.framework.core {
	import flash.utils.Dictionary;
	import maryfisher.framework.command.asset.InitAssetCommand;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AssetController {
		
		static private var _instance:AssetController;
		
		private var _mapping:Dictionary;
		private var _cachedAssets:Dictionary;
		
		public function AssetController() {
			
			_cachedAssets = new Dictionary();
		}
		
		static public function getInstance():AssetController {
			if (!_instance) {
				_instance = new AssetController();
				
			}
			return _instance;
		}
		static public function init(mapping:Dictionary):void {
			getInstance()._mapping = mapping;
			
		}
		
		static public function registerCommand(cmd:InitAssetCommand):void {
			_instance.executeCommand(cmd);
		}
		
		public function executeCommand(cmd:InitAssetCommand):void {
			if (_cachedAssets[cmd.id + cmd.fileId] != null) {
				var cl:Class = _mapping[cmd.id];
				_cachedAssets[cmd.id + cmd.fileId] = new cl();
			}
			
			cmd.setAsset(_cachedAssets[cmd.id + cmd.fileId]);
		}
		
	}

}