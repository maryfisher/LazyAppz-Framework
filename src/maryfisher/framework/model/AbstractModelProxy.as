package maryfisher.framework.model {
	
	import flash.utils.Dictionary;
	import maryfisher.framework.core.ModelController;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractModelProxy {
		
		protected var _models:Dictionary;
		protected var _allModelsLoaded:Boolean = false;
		private var _priority:int;
		private var _updateListeners:Dictionary;
		
		public function AbstractModelProxy(priority:int = 0) {
			_priority = priority;
			_models = new Dictionary();
			_updateListeners = new Dictionary();
			
			ModelController.registerProxy(this);
			
			dataFinishedLoading(AbstractModel.LATEST_DATA);
		}
		
		public function addModel(modelType:Class, model:AbstractModel):void {
			_models[modelType] = model;
			model.registerForUpdate(this);
		}
		
		public function dataFinishedLoading(dataType:String):void {
			var dataLoaded:Boolean = true;
			
			for each (var model:AbstractModel in _models) {
				if (model.status == AbstractModel.DATA_WAITING) {
					//trace("[AbstractProxy] dataFinishedLoading", this, "model not loaded", model);
					dataLoaded = false;
					break;
				}
			}
			
			if (dataLoaded) {
				_allModelsLoaded = true;
				onModelsLoaded(dataType);
			}
		}
		
		protected function onModelsLoaded(dataType:String):void {
		
		}
		
		public function registerForUpdate(callback:Function, modelClass:String):void {
			_updateListeners[modelClass] = callback;
		}
		
		public function updateFromModel(update:BaseModelUpdate):void {
			if (update.updateId == AbstractModel.DATA_LOADED) {
				dataFinishedLoading((update as ModelStatusUpdate).dataType);
			} else {
				var func:Function = _updateListeners[update.updateId];
				if (func == null)
					return;
				func(update);
			}
		}
		
		public function destroy():void {
			_updateListeners = null;
			for each (var model:AbstractModel in _models) {
				model.unregisterForUpdate(this);
			}
		}
		
		public function get priority():int {
			return _priority;
		}
	}
}