package maryfisher.framework.data {
	import flash.utils.Dictionary;
	/**
	 * Alle spezifischeren Updates mit spezifischen Objekten leiten von dieser Klasse ab
	 * ODER
	 * man übergibt updateObjects an ein Dictionary, nach Typ/Klasse geordnet
	 * @author mary_fisher
	 */
	public class ModelUpdateData {
		
		private var _updateType:String;
		//private var _updateObjects:Dictionary; /* Class/Type => Object */
		
		public function ModelUpdateData(updateType:String) {
			_updateType = updateType;
			
		}
		
		public function get updateType():String { return _updateType; }
		
		//public function getUpdateObject(type:Class):Object {
			//return _updateObjects[type];
		//}
	}

}