package maryfisher.framework.command.loader {
	import controller.command.global.GlobalCommand;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import org.osflash.signals.Signal;
	import org.papervision3d.events.FileLoadEvent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LoaderCommand extends GlobalCommand{
		
		private var _percent:Number = 0;
		private var _id:String;
		private var _priority:int;
		private var _finishedLoading:Signal;
		private var _percentLoading:Signal;
		private var _description:String;
		
		protected var _assetPath:String;
		protected var _callback:ILoadingCallback;
		protected var _doCache:Boolean;
		
		public function LoaderCommand(id:String, assetPath:String, callback:ILoadingCallback, description:String = '', doCache:Boolean = false) {
			_assetPath = assetPath;
			_description = description;
			_doCache = doCache;
			
			_id = id;
			/** TODO
			 * mit eigenen Interfaces spezifizieren und in XMLLoaderCommand ect auslagern
			 */
			_callback = callback;
			_finishedLoading = new Signal(LoaderCommand);
			_percentLoading = new Signal(LoaderCommand);
			_finishedLoading.addOnce(_callback.loadingFinished);
			execute();
		}
		
		public function loadAsset():void {
			
		}
		
		protected function setProgress(progress:Number):void {
			_percent = progress;
			_percentLoading.dispatch(this);
		}
		
		public function get percent():Number { return _percent; }
		
		public function setFinished():void {
			_finishedLoading.dispatch(this);
			_percentLoading.removeAll();
		}
		
		public function get asset():Object {
			return null;
		}
		
		public function set asset(tasset:Object):void {
			
		}
		
		public function leachLoading(cmd:LoaderCommand):void {
			asset = cmd.asset;
			//if (cmd.asset != null) {
				//assetClass = cmd.assetClass;
			//}else {
				//
			//}
		}
		
		public function get finishedLoading():Signal { return _finishedLoading; }
		public function get percentLoading():Signal { return _percentLoading; }
		
		public function get description():String { return _description; }
		public function set description(value:String):void {
			_description = value;
		}
		
		public function get priority():int { return _priority; }
		public function set priority(value:int):void {
			_priority = value;
		}
		
		public function get id():String { return _id; }
		
		public function get doCache():Boolean { return _doCache; }
	}

}