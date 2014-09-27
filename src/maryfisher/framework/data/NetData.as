package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class NetData {
		
		//use for url purposes
		public var id:String;
		public var requestClass:Class;
		public var controllerId:String;
		
		public function NetData(id:String, controllerId:String, requestClass:Class = null) {
			this.controllerId = controllerId;
			this.requestClass = requestClass;
			this.id = id; 
			
		}
		
	}
}