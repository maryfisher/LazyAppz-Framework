package maryfisher.framework.data {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseData {
		
		public function BaseData(data:*) {
			if (!data) return;
			dataSwitch(data);
		}
		
		protected function parseXML(xml:XML):void {
			
		}
		
		protected function parseObject(data:Object):void {
			
		}
		
		protected function dataSwitch(data:*):void {
			if (data is XML) {
				parseXML(data as XML);
			}else {
				parseObject(data);
			}
		}
		
	}

}