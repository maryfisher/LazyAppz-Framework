package maryfisher.framework.command.loader {
	import maryfisher.framework.data.LoaderData;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SoundLoaderCommand extends LoaderCommand {
		
		public function SoundLoaderCommand(id:String, fileId:String, callback:Function, priority:int=0, executeInstantly:Boolean=true) {
			_finishedLoading = new Signal(LoaderCommand);
			_finishedLoading.addOnce(callback);
			super(id, fileId, priority, executeInstantly);
			
		}
		
		override public function loadAsset(loaderData:LoaderData):void {
			super.loadAsset(loaderData);
		}
	}

}