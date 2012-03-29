package maryfisher.framework.command.view {
	import maryfisher.framework.command.loader.LoaderCommand;
	import maryfisher.framework.data.LoaderData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LoadingProgress extends AbstractProgress {
		private var _loaderData:LoaderData;
		
		public function LoadingProgress(cmd:LoaderCommand, loaderData:LoaderData) {
			cmd.percentLoading.add(onProgress);
			cmd.finishedLoading.addOnce(finishedLoading);
			_loaderData = loaderData;
			super();
		}
		
		private function finishedLoading(cmd:LoaderCommand):void {
			_progress = 1;
			getProgress();
		}
		
		public function onProgress(cmd:LoaderCommand):void {
			_progress = cmd.percent;
			getProgress();
			//trace("LoadingProgress:", _progress, getDescription());
		}
		
		override public function getDescription():String {
			return _loaderData.description;
		}
	}

}