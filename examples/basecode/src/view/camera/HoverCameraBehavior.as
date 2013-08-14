package view.camera {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class HoverCameraBehavior extends AbstractCameraBehavior {
		
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _lastStageX:Number;
		private var _lastStageY:Number;
		private var _move:Boolean;
		
		public function HoverCameraBehavior(cameraController:BaseCameraController) {
			super(cameraController);
			
		}
		
		override public function start(stage:Stage):void {
			super.start(stage);
			CONFIG::mouse{
				_stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onRightMouseDown);
				_stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, onRightMouseUp);
			}
			CONFIG::touch{
				stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			}
		}
		
		CONFIG::mouse
		private function onRightMouseUp(e:MouseEvent):void {
			_move = false;
			//_stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		CONFIG::mouse
		private function onRightMouseDown(e:MouseEvent):void {
			_lastPanAngle = _cameraController.currentPanAngle;
			_lastTiltAngle = _cameraController.currentTiltAngle;
			_lastStageX = _stage.mouseX;
			_lastStageY = _stage.mouseY;
			_move = true;
			//_stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		CONFIG::mouse
		private function onStageMouseLeave(event:Event):void {
			_move = false;
			_stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		CONFIG::touch
		private function onTouchBegin(e:TouchEvent):void {
			_lastPanAngle = _currentPanAngle;
			_lastTiltAngle = _currentTiltAngle;
			_lastStageX = _stage.mouseX;
			_lastStageY = _stage.mouseY;
			_move = true;
			_stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		CONFIG::touch
		private function onTouchEnd(e:TouchEvent):void {
			_move = false;
			_stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		override public function onEnterFrame(e:Event):void {
			if (_move) {
				_cameraController.panAngle = 0.3 * (_stage.mouseX - _lastStageX) + _lastPanAngle;
				_cameraController.tiltAngle = 0.3 * (_stage.mouseY - _lastStageY) + _lastTiltAngle;
			}
			//super.onEnterFrame(e);
			
		}
	}

}