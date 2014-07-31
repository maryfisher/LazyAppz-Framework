package maryfisher.framework.core {
	
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import maryfisher.framework.model.AbstractModel;
	import maryfisher.framework.model.AbstractProxy;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ModelController {
		
		protected var _models:Dictionary;
		static private var _instance:ModelController;
		
		public function ModelController() {
			
		}
		
		static private function getInstance():ModelController {
			if (!_instance) {
				_instance = new ModelController();
				
			}
			return _instance;
		}
		
		static public function init(models:Dictionary):void {
			getInstance()._models = models;
			
		}
		
		static public function initModels():void {
			for each (var item:AbstractModel in _instance._models) {
				item.init();
			}
		}
		
		static public function registerProxy(abstractProxy:AbstractProxy):void {
			if (!_instance._models) {
				return;
			}
			_instance.register(abstractProxy);
			//var typeXML:XML = describeType(abstractProxy);
			//for each(var intFace:XML in typeXML.implementsInterface) {
				//var classDef:Class = getDefinitionByName(intFace.@type) as Class;
				//
				//var model:AbstractModel = _instance._models[classDef];
				//var model:AbstractModel = _instance._models[intFace.@type];
				//if (model != null) {
					//var modelName:String = getQualifiedClassName(model);
					//var accessors:XMLList = typeXML.accessor.(@type == modelName);
					//if (accessors) {
						//abstractProxy[accessors[0].@name] = model;
					//}
				//}
			//}
		}
		
		private function register(registered:*):void {
			var typeXML:XML = describeType(registered);
			for each(var intFace:XML in typeXML.implementsInterface) {
				var str:String = intFace.@type;
				var model:AbstractModel = _models[str];
				if (model) {
					var modelName:String = model.className;
					var accessors:XMLList = typeXML.accessor.(@type == modelName);
					if (accessors.length() > 0) {
						registered[accessors[0].@name] = model;
						registered.addModel(getDefinitionByName(modelName), model);
						
						
					}
				}
			}
			
			for each (var item:XML in typeXML.method) {
				var listName:String = item.@name;
				if (String(listName).indexOf("on") != -1){// && String(listName).indexOf("Update")) {
					//var t:String = item.parameter[0].@type;
					(registered as AbstractProxy).registerForUpdate(registered[listName], listName);
				}
			}
		}
		
		static public function registerForModel(reg:*):void {
			if (!_instance._models) {
				return;
			}
			_instance.register(reg);
		}
	}
}