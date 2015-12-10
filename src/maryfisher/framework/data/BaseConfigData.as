package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseConfigData extends BaseData {
		
		public var id:int;
		
		public function BaseConfigData(data:*) {
			super(data);
			
		}
		
		override protected function parseObject(data:Object):void {
			id = data.id;
		}
	}

}