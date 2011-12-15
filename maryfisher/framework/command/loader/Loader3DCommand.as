package maryfisher.framework.command.loader {
	//import away3d.core.base.Object3D;
	import config.LoaderConfig;
	import org.papervision3d.events.FileLoadEvent;
	import org.papervision3d.objects.parsers.DAE;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Loader3DCommand extends LoaderCommand {
		
		
		//private var _modelName:String;
		private var _model:DAE;
		//private var _model3D:Object3D;
		
		public function Loader3DCommand(id:String, path:String, callback:ILoadingCallback, description:String = '') {
			super(id, path, callback, description);
			//_modelName = path;
			//loadModel();
		}
		
		
		public function loadModel():void {
			
			_model = new DAE(false);
			_model.addEventListener(FileLoadEvent.LOAD_COMPLETE, onModelLoad);
			_model.addEventListener(FileLoadEvent.BUILD_COMPLETE, onBuildComplete);
			_model.addEventListener(FileLoadEvent.LOAD_PROGRESS, onProgress, false, 0, true);
			//_model.addEventListener(FileLoadEvent.ANIMATIONS_COMPLETE, animationComplete);
			_model.addFileSearchPath(LoaderConfig.TEXTURE_PATH + _assetPath);
			_model.load(LoaderConfig.MODEL_PATH + _assetPath + ".DAE", null, true);
		}
		
		public function loadModel3D():void {
			//var loader:;
			//loader = Colla.load(".dae", { scaling:.25} );
			//loader.addOnSuccess(onLoaderSuccess);
		}
		
		protected function onBuildComplete(ev:FileLoadEvent):void {
			setFinished();
		}
		
		protected function onModelLoad(ev:FileLoadEvent):void {
			
		}
		
		protected function onProgress(ev:FileLoadEvent):void {
			//trace('onProgress');
			setProgress(ev.bytesLoaded / ev.bytesTotal);
		}
		
		public function get model():DAE { return _model; }
		
		//public function get model3D():Object3D {
			//return _model3D;
		//}
	}

}