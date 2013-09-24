package maryfisher.framework.command.loader {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import maryfisher.framework.data.LoaderData;
	import maryfisher.sound.BaseSound;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SoundLoaderCommand extends LoaderCommand {
		
		private var _sound:Sound;
		//private var _baseSound:BaseSound;
		
		public function SoundLoaderCommand(id:String, fileId:String, callback:Function, priority:int=0, executeInstantly:Boolean=true) {
			_finishedLoading = new Signal(LoaderCommand);
			_finishedLoading.addOnce(callback);
			super(id, fileId, priority, executeInstantly);
			
		}
		
		override public function loadAsset(loaderData:LoaderData):void {
			super.loadAsset(loaderData);
			
			_sound = new Sound();
			
			_sound.addEventListener(Event.COMPLETE, onSoundLoaded);
			_sound.addEventListener(IOErrorEvent.IO_ERROR, onError);
			_sound.addEventListener(ProgressEvent.PROGRESS, onLoadingProgress);
			_sound.load(new URLRequest(_loaderData.path + _fileId + ".mp3"));
			//_loader.load(new URLRequest(_loaderData.path + ".swf"));
		}
		
		private function onLoadingProgress(ev:ProgressEvent):void {
			setProgress(ev.bytesLoaded / ev.bytesTotal);
		}
		
		private function onSoundLoaded(e:Event):void {
			//_baseSound = new BaseSound(_sound);
			setFinished();
		}
		
		override public function get asset():Object {
			//return _baseSound;
			return _sound;
		}
		
		override public function set asset(value:Object):void {
			//_baseSound = value;
			_sound = value as Sound;
		}
		
		private function onError(e:IOErrorEvent):void {
			trace('[SOUNDLOADERCOMMAND]: ' + e.text);
		}
	}

}