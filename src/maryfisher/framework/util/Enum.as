package maryfisher.framework.util {
	
	import flash.utils.getQualifiedClassName;
	import flash.utils.describeType;
	
	/**
	 * This class is provided by Scott Bilas at http://scottbilas.com/blog/ultimate-as3-fake-enums/
	 * I modified it slightly to fit my own naming conventions
	 */
	
	public /*abstract*/class Enum {
		public function get name():String {
			return _name;
		}
		
		public function get index():int {
			return _index;
		}
		
		public /*override*/function toString():String {
			return name;
		}
		
		public static function getConstants(i_type:Class):Vector.<Enum> {
			var constants:EnumConstants = _enumDb[getQualifiedClassName(i_type)];
			if (constants == null)
				return null;
			
			return constants.getByIndex();
		}
		
		public static function parseConstant(i_type:Class, i_constantName:String, i_caseSensitive:Boolean = false):Enum {
			var constants:EnumConstants = _enumDb[getQualifiedClassName(i_type)];
			if (constants == null)
				return null;
			
			var constant:Enum = constants.getConstantByName(i_constantName.toLowerCase());
			if (i_caseSensitive && (constant != null) && (i_constantName != constant.name))
				return null;
			
			return constant;
		}
		
		/*-----------------------------------------------------------------*/
		
		/*protected*/
		function Enum() {
			var typeName:String = getQualifiedClassName(this);
			
			// discourage people new'ing up constants on their own instead
			// of using the class constants
			if (_enumDb[typeName] != null) {
				throw new Error("Enum constants can only be constructed as static consts " + "in their own enum class " + "(bad type='" + typeName + "')");
			}
			
			// if opening up a new type, alloc an array for its constants
			var constants:Vector.<Enum> = _pendingDb[typeName];
			if (constants == null)
				_pendingDb[typeName] = constants = new Vector.<Enum>();
			
			// record
			_index = constants.length;
			constants.push(this);
		}
		
		protected static function initEnum(i_type:Class):void {
			var typeName:String = getQualifiedClassName(i_type);
			
			// can't call initEnum twice on same type (likely copy-paste bug)
			if (_enumDb[typeName] != null) {
				throw new Error("Can't initialize enum twice (type='" + typeName + "')");
			}
			
			// no constant is technically ok, but it's probably a copy-paste bug
			var constants:Vector.<Enum> = _pendingDb[typeName];
			if (constants == null) {
				throw new Error("Can't have an enum without any constants (type='" + typeName + "')");
			}
			
			// process constants
			var type:XML = flash.utils.describeType(i_type);
			for each (var constant:XML in type.constant) {
				// this will fail to coerce if the type isn't inherited from Enum
				var enumConstant:Enum = i_type[constant.@name];
				
				// if the types don't match then probably have a copy-paste error.
				// this is really common so it's good to catch it here.
				var enumConstantType:* = Object(enumConstant).constructor;
				if (enumConstantType != i_type) {
					throw new Error("Constant type '" + enumConstantType + "' " + "does not match its enum class '" + i_type + "'");
				}
				
				enumConstant._name = constant.@name;
			}
			
			// now seal it
			_pendingDb[typeName] = null;
			_enumDb[typeName] = new EnumConstants(constants);
		}
		
		private var _name:String = null;
		private var _index:int = -1;
		
		private static var _pendingDb:Object = {}; // typename -> Vector.<Enum>([constants])
		private static var _enumDb:Object = {}; // typename -> EnumConstants
	}
	
	// private support class
	class EnumConstants {
		public function EnumConstants(byIndex:Vector.<Enum>) {
			_byIndex = byIndex;
			
			for (var i:int = 0; i < _byIndex.length; ++i) {
				var enumConstant:Enum = _byIndex[i];
				_byName[enumConstant.name.toLowerCase()] = enumConstant;
			}
		}
		
		public function getConstantByName(name:String):EnumConstants {
			return _byName[name];
		}
		
		// return a copy to prevent caller modifications
		public function getByIndex():void {
			return _byIndex.slice();
		}
		
		private var _byIndex::Vector.<Enum>;
		private var _byName:Object = {};
	}
}

