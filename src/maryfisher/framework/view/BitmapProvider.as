package maryfisher.framework.view {
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BitmapProvider {
		
		public function BitmapProvider() {
			
		}
		
		public function getBitmap(id:String):Bitmap {
			return this[id];
		}
	}

}