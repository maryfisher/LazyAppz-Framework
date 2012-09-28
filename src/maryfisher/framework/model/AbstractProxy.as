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
		
		//protected var _updateSignal:Signal;
		private var _models:Dictionary;
		private var _updateListeners:Dictionary;
		protected var _allModelsLoaded:Boolean = false;
		
		public function AbstractProxy() {
			//_updateSignal = new Signal();
			_models = new Dictionary();
			_updateListeners = new Dictionary();
			
			ModelController.registerProxy(this);
			
			dataFinishedLoading();
		}
		
		public function addModel(modelType:Class, model:AbstractModel):void {
			_models[modelType] = model;
			model.registerForUpdate(this);
		}
		
		public function dataFinishedLoading():void {
			var dataLoaded:Boolean = true;
			
			for each(var model:AbstractModel in _models) {
				if (model.status == AbstractModel.DATA_WAITING) {
					dataLoaded = false;
					break;
				}
			}
			
			if (dataLoaded) {
				_allModelsLoaded = true;
				onModelsLoaded();
				//_updateSignal.dispatch();
			}
		}
		
		protected function onModelsLoaded():void {
			
		}
		
		public function registerForUpdate(callback:Function, modelClass:String):void {
			_updateListeners[modelClass] = callback;
		}
		
		public function updateFromModel(update:BaseModelUpdate):void {
			if (update.updateId == AbstractModel.DATA_LOADED) {
				dataFinishedLoading();
			}else {
				_updateListeners[update.updateId](update);
			}
		}
		
		public function destroy():void {
			//_updateSignal.removeAll();
			for each(var model:AbstractModel in _models) {
				model.unregisterForUpdate(this);
			}
		}
	}
}