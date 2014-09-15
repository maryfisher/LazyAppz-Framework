package maryfisher.framework.model {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ModelStatusUpdate extends BaseModelUpdate {
		public var dataType:String;
		
		public function ModelStatusUpdate(updateId:String, dataType:String) {
			super(updateId);
			this.dataType = dataType;
			
		}
		
	}

}