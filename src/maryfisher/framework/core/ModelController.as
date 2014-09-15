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
        private var _modelUpdates:Dictionary;
		
		public function ModelController() {
			_modelUpdates = new Dictionary();
			
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
			for each (var model:AbstractModel in _instance._models) {
				model.init();
                var modelClass:Class = getDefinitionByName(model.className) as Class;
                var typeXML:XML = describeType(modelClass);
                var constants:Array = [];
                for each(var constant:XML in typeXML.constant) 
                {
                    constants.push(modelClass[constant.@name]);
                }
                _instance._modelUpdates[model.className] = constants;
			}
		}
		
		static public function registerProxy(abstractProxy:AbstractProxy):void {
			if (!_instance || !_instance._models) {
				return;
			}
			_instance.register(abstractProxy);
		}
		
		private function register(registered:*):void {
			var typeXML:XML = describeType(registered);
			for each(var intFace:XML in typeXML.implementsInterface) {
				var interfaceType:String = intFace.@type;
				var model:AbstractModel = _models[interfaceType];
				if (model) {
					var modelName:String = model.className;
					var accessors:XMLList = typeXML.accessor.(@type == modelName);
					if (accessors.length() > 0) {
						registered[accessors[0].@name] = model;
						registered.addModel(getDefinitionByName(modelName), model);
						
						
					}
                    var constants:Array = _modelUpdates[modelName];
                    for each (var constantName:String in constants) 
                    {
                        var methods:XMLList = typeXML.method.(@name == constantName);
                        if (methods.length() > 0)
                        {
                            var methodName:String = methods[0].@name;
                            (registered as AbstractProxy).registerForUpdate(registered[methodName], methodName);
                        }
                    }
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