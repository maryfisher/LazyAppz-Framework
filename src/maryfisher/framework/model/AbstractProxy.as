package maryfisher.framework.model {
	
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import maryfisher.framework.core.ModelController;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractProxy {
		
		protected var _updateSignal:Signal;
		//private var _modelIds:Vector.<String>;
		private var _models:Dictionary;
		private var _updateSignals:Dictionary;
		
		public function AbstractProxy() {
			//_updateSignal = new Signal(String);
			_updateSignal = new Signal(BaseModelUpdate);
			_models = new Dictionary();
			_updateSignals = new Dictionary();
			
			ModelController.registerProxy(this);
			
			//_modelIds = new Vector.<String>();
			//var typeXML:XML = describeType(this);
			//trace(typeXML);
			//var accessors:XMLList = typeXML.accessor;//.(@name.indexOf('Model') > -1);
			//for each(var accessor:XML in accessors) {
				//var modelname:String = accessor.@name;
				//if (modelname.indexOf('Model') > -1 ) {
					//_models.push('_' + modelname);
					//_modelIds.push(modelname);
				//}
			//}
		}
		
		public function addModel(modelType:Class, model:AbstractModel):void {
			_models[modelType] = model;
		}
		
		public function get updateSignal():Signal { return _updateSignal; }
		
		public function dataFinishedLoading():void {
			var dataLoaded:Boolean = true;
			
			for each(var model:AbstractModel in _models) {
				if (model.status == AbstractModel.DATA_WAITING) {
					dataLoaded = false;
					break;
				}
			}
			
			if (dataLoaded) {
				_updateSignal.dispatch(new BaseModelUpdate(AbstractModel.DATA_LOADED));
			}
		}
		
		//public function registerForUpdate(updater:IProxyUpdate, param:Vector.<String> = null):void {
		//public function registerForUpdate(callback:Function, param:Vector.<String> = null):void {
			//for each(var modelname:String in _modelIds) {
				//(this[modelname] as AbstractModel).registerForUpdate(this);
			//}
			//_updateSignal.add(callback);
			//dataFinishedLoading();
		//}
		
		public function registerForUpdate(callback:Function, modelClass:Class = null):void {
			if (!modelClass) {
				for each(var model:AbstractModel in _models) {
					model.registerForUpdate(this);
				}
				_updateSignal.add(callback);
				dataFinishedLoading();
			}else {
				if (!_updateSignals[modelClass]) {
					_updateSignals[modelClass] = new Signal(BaseModelUpdate);
				}
				_updateSignals[modelClass].add(callback);
				(_models[modelClass] as AbstractModel).registerForUpdate(this);
			}
			//for each(var modelname:String in _modelIds) {
				//(this[modelname] as AbstractModel).registerForUpdate(this);
			//}
		}
		
		public function updateFromModel(update:BaseModelUpdate):void {
			if (update.updateId == AbstractModel.DATA_LOADED) {
				dataFinishedLoading();
			}else {
				_updateSignal.dispatch(update);
				update.updateType && _updateSignals[update.updateType] && _updateSignals[update.updateType].dispatch(update);
				//Boolean(int(update.updateType != null) & int(_updateSignals[update.updateType] != null))
					//&& _updateSignals[update.updateType].dispatch(update);
			}
		}
		
		public function destroy():void {
			_updateSignal.removeAll();
			for each(var signal:Signal in _updateSignals) {
				signal.removeAll();
			}
			for each(var model:AbstractModel in _models) {
				model.unregisterForUpdate(this);
			}
			//for each(var modelname:String in _modelIds) {
				//(this[modelname] as AbstractModel).unregisterForUpdate(this);
			//}
		}
	}
}