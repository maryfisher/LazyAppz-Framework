package maryfisher.framework.view {
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.view.IViewComponent;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ViewComponentSprite extends Sprite implements IViewComponent {
		
		protected var _position:Point;
		protected var _updateSignal:Signal;
		
		public function ViewComponentSprite() {
			_position = new Point();
			_updateSignal = new Signal();
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function destroy():void {
			
		}
		
		public function get rect():Rectangle {
			return new Rectangle(x, y, width, height);
		}
		
		public function set position(value:Point):void {
			_position = value;
			x = value.x;
			y = value.y;
		}
		
		public function get componentType():String {
			return ViewController.SPRITE;
		}
		
		public function get position():Point {
			_position.x = x;
			_position.y = y;
			return _position;
		}
		
		public function get updateSignal():Signal {
			return _updateSignal;
		}
		
	}

}