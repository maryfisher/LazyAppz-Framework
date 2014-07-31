package maryfisher.framework.view.core {
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import maryfisher.framework.view.IImageBuilder;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseImageBuilder extends Sprite implements IImageBuilder {
		
		private var _datas:Dictionary;
		
		public function BaseImageBuilder() {
			_datas = new Dictionary();
		}
		
		protected function getData(id:Class):BitmapData {
			if (!_datas[id]) {
				_datas[id] = new id().bitmapData;
			}
			return _datas[id];
		}
		
		/* INTERFACE maryfisher.framework.view.IImageBuilder */
		
		public function getImage(id:String):BitmapData {
			return null;
		}
		
	}

}