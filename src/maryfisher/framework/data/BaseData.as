package maryfisher.framework.data {
	import flash.geom.Point;
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
		
		protected function getPoint(str:String, del:String = ","):Point {
			if (validateString(str)) {
				var s:Array = str.split(del);
				return new Point(s[0], s[1]);
			}else {
				return new Point();
			}
		}
		
		protected function validateString(str:String):Boolean {			
			if (str == null || str == "" || str == " ") {
				return false;
			}
			
			return true;
		}
	}

}