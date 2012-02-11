package maryfisher.framework.model {
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractConfigModel extends AbstractModel {
		
		public function AbstractConfigModel() {
			super();
			
		}
		
		protected function parseXML(xml:Class):XML {
			var ba:ByteArray = new xml() as ByteArray;
			var s:String = ba.readUTFBytes( ba.length );
			return  XML(s);
		}
	}

}