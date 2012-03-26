package maryfisher.framework.model {
	
	import flash.utils.describeType;
	import maryfisher.framework.core.ModelController;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractProxy {
		
		protected var _updateSignal:Signal;
		private var _models:Vector.<String>;
		
		public function AbstractProxy() {
			_updateSignal = new Signal(String);
			//_updateSignal = new Signal(ModelUpdate);
			ModelController.registerProxy(this);
			
			_models = new Vector.<String>();
			var typeXML:XML = describeType(this);
			var accessors:XMLList = typeXML.accessor;//.(@name.indexOf('Model') > -1);
			for each(var accessor:XML in accessors) {
				var modelname:String = accessor.name;
				if (modelname.indexOf('Model') > -1 ) {
					_models.push('_' + modelname);
				}
			}
		}
		
		public function get updateSignal():Signal { return _updateSignal; }
		
		public function dataFinishedLoading():void {
			var dataLoaded:Boolean = true;
			
			for each(var modelname:String in _models) {
				if ((this[modelname] as AbstractModel).status == AbstractModel.DATA_WAITING) {
					dataLoaded = false;
				}
			}
			
			if (dataLoaded) {
				_updateSignal.dispatch(new BaseModelUpdate(AbstractModel.DATA_LOADED));
			}
		}
		
		//public function registerForUpdate(updater:IProxyUpdate, param:Vector.<String> = null):void {
		public function registerForUpdate(callback:Function, param:Vector.<String> = null):void {
			for each(var modelname:String in _models) {
				(this[modelname] as AbstractModel).registerForUpdate(this);
			}
			_updateSignal.add(callback);
			dataFinishedLoading();
		}
		
		public function updateFromModel(update:BaseModelUpdate):void {
			if (update.updateId == AbstractModel.DATA_LOADED) {
				dataFinishedLoading();
			}else {
				_updateSignal.dispatch(update);
			}
		}
		
		public function destroy():void {
			_updateSignal.removeAll();
			for each(var modelname:String in _models) {
				(this['_' + modelname] as AbstractModel).unregisterForUpdate(this);
			}
		}
	}
}