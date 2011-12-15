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
			
			var typeXML:XML = describeType(abstractProxy);
			for each(var intFace:XML in typeXML.implementsInterface) {
				var classDef:Class = getDefinitionByName(intFace.@type) as Class;
				
				var model:AbstractGlobalModel = _instance._models[classDef];
				if (model != null) {
					var modelName:String = getQualifiedClassName(model);
					var accessors:XMLList = typeXML.accessor.(@type == modelName);
					if (accessors) {
						abstractProxy[accessors[0].@name] = model;
					}
				}
			}
		}
	}
}