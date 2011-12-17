package maryfisher.framework.core {
	
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ModelController {
		
		protected var _models:Dictionary;
		static private var _instance:ModelController;
		
		public function ModelController() {
			_instance = this;
		}
		
		public function init(models:Dictionary):void {
			_models = models;
			/* TODO
			 * getQualifiedClassName
			 */
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
				//var classDef:Class = getDefinitionByName(intFace.@type) as Class;
				
				//var model:AbstractModel = _instance._models[classDef];
				var model:AbstractModel = _models[intFace.@type];
				if (!model) {
					var modelName:String = getQualifiedClassName(model);
					var accessors:XMLList = typeXML.accessor.(@type == modelName);
					if (accessors) {
						abstractProxy[accessors[0].@name] = model;
					}
				}
			}
		}
		
		static public function registerForModel():void {
			
		}
	}
}