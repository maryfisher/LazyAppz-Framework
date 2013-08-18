package data {
	import maryfisher.framework.data.BaseData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class GameConfigData extends BaseData{
		
		public var info:String;
		
		public function GameConfigData(data:*) {
			super(data);
		}
		
		override protected function parseObject(d:Object):void {
			super.parseObject(d);
			
			info = d.info;
		}
	}

}