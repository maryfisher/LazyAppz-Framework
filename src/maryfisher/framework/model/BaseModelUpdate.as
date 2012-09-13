package maryfisher.framework.model {
	import flash.utils.Dictionary;
	/**
	 * Alle spezifischeren Updates mit spezifischen Objekten leiten von dieser Klasse ab
	 * ODER
	 * man übergibt updateObjects an ein Dictionary, nach Typ/Klasse geordnet
	 * @author mary_fisher
	 */
	public class BaseModelUpdate {
		
		private var _updateId:String;
		//private var _updateType:Class;
		//private var _updateObjects:Dictionary; /* Class/Type => Object */
		
		public function BaseModelUpdate(updateId:String) {
			//_updateType = updateType;
			_updateId = updateId;
			
		}
		
		public function get updateId():String { return _updateId; }
		
		//public function get updateType():Class {
			//return _updateType;
		//}
		
		//public function set updateType(value:Class):void {
			//_updateType = value;
		//}
		
		//public function getUpdateObject(type:Class):Object {
			//return _updateObjects[type];
		//}
	}

}