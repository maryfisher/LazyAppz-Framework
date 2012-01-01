package maryfisher.framework.command.loader {
	import maryfisher.framework.config.LoaderConfig;
	import maryfisher.framework.core.LoaderController;
	import maryfisher.framework.data.LoaderData;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class LoaderCommand{
		
		private var _percent:Number = 0;
		private var _id:String;
		private var _priority:int;
		protected var _finishedLoading:Signal;
		private var _percentLoading:Signal;
		protected var _loaderData:LoaderData;
		
		public function LoaderCommand(id:String, priority:int = LoaderConfig.WHENEVER_PRIORITY) {
			_priority = priority;	
			_id = id;
			if (!_finishedLoading) _finishedLoading = new Signal(LoaderCommand);
			_percentLoading = new Signal(LoaderCommand);
			execute();
		}
		
		private function execute():void {
			LoaderController.registerCommand(this);
		}
		
		public function loadAsset(loaderData:LoaderData):void {
			_loaderData = loaderData;
			
			
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
			setFinished();
		}
		
		public function get finishedLoading():Signal { return _finishedLoading; }
		public function get percentLoading():Signal { return _percentLoading; }
		
		public function get priority():int { return _priority; }
		public function set priority(value:int):void {
			_priority = value;
		}
		
		public function get id():String { return _id; }
		
		public function get loaderData():LoaderData {
			return _loaderData;
		}
	}

}