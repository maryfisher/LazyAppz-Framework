package maryfisher.framework.components {
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import maryfisher.framework.event.ButtonEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SpriteButton extends Sprite {
		
		protected var _tooltip:ITooltip;
		
		protected var _enabled:Boolean;
		protected var _selected:Boolean;
		
		protected var _upState:DisplayObject;
		protected var _overState:DisplayObject;
		protected var _downState:DisplayObject;
		protected var _disabledState:DisplayObject;
		protected var _selectedState:DisplayObject;
		protected var _defaultState:DisplayObject;
		protected var _hitTest:DisplayObject;
		
		protected var _id:String;
		
		public function SpriteButton(id:String) {
			_enabled = true;
			_selected = false;
			_id = id;
			mouseChildren = false;
			buttonMode = true;
			
			addListeners();
		}
		
		private function addListeners():void {
			if (_hitTest) {
				_hitTest.addEventListener(MouseEvent.ROLL_OVER, handleMouseOver, false, 0, true);
				_hitTest.addEventListener(MouseEvent.CLICK, handleMouseUp, false, 0, true);
				_hitTest.addEventListener(MouseEvent.ROLL_OUT, handleMouseOut, false, 0, true);
				return;
			}
			
			addEventListener(MouseEvent.ROLL_OVER, handleMouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown, false, 0, true);
			addEventListener(MouseEvent.MOUSE_UP, handleMouseUp, false, 0, true);
			addEventListener(MouseEvent.ROLL_OUT, handleMouseOut, false, 0, true);
		}
		
		public function destroy():void {
			removeListeners();
		}
		
		private function removeListeners():void {
			if(!_hitTest){
				removeEventListener(MouseEvent.ROLL_OVER, handleMouseOver, false);
				removeEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown, false);
				removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp, false);
				removeEventListener(MouseEvent.ROLL_OUT, handleMouseOut, false);
				return;
			}
		}
		
		protected function handleMouseDown(e:MouseEvent):void {
			if (!_enabled || _selected) {
				return;
			}
			if(_downState) _downState.visible = false;
			
		}
		
		protected function handleMouseOver(e:MouseEvent):void {
			if (!_enabled || _selected) {
				return;
			}
				/* TODO
				 * Tween!
				 */	
			if(_upState) _upState.visible = false;
			if(_overState) _overState.visible = true;
			
		}
		
		protected function handleMouseOut(e:MouseEvent):void {
			if (!_enabled || _selected) {
				return;
			}
			if(_upState) _upState.visible = true;
			if(_overState) _overState.visible = false;
			if(_downState) _downState.visible = false;
			
		}
		
		protected function handleMouseUp(e:MouseEvent):void {
			if (!_enabled) {
				return;
			}
			if(_downState) _downState.visible = false;
			dispatchEvent(new ButtonEvent(ButtonEvent.BUTTON_CLICKED, _id));
		}
		
		public function attachTooltip(tooltip:ITooltip):void {
			_tooltip = tooltip;
			
		}
		
		public function set selected(value:Boolean):void {
			trace('selected ', value, _selected);
			if (_selected == value) {
				return;	
			}
			
			_selected = value;
			if (_selected) {
				upState = _selectedState;
			}else {
				upState = _defaultState;
			}
			handleMouseOut(null);
			
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled == value) {
				return;
			}
			
			if (!value) {
				handleMouseOut(null);
				removeListeners();
				_selected = false;
			}else {
				addListeners();
			}
			
			_enabled = value;
			mouseEnabled = _enabled;
			buttonMode = _enabled;
			
			if (!value) {
				if(_disabledState) upState = _disabledState;
			}else {
				if(_defaultState) upState = _defaultState;
			}
			
		}
		
		public function get id():String { return _id; }
		
		protected function set upState(value:DisplayObject):void {
			if (_upState) {
				if (contains(_upState)) removeChild(_upState);
			}
			_upState = value;
			addChildAt(_upState, 0);
		}
		
		protected function set overState(value:DisplayObject):void {
			_overState = value;
			_overState.visible = false;
			if (_downState) {
				addChildAt(_overState, numChildren - 2);
				return;
			}
			addChild(_overState);
		}
		
		protected function set downState(value:DisplayObject):void {
			_downState = value;
			_downState.visible = false;
			addChild(_downState);
		}
		
		protected function set hitTest(value:DisplayObject):void {
			_hitTest = value;
			mouseChildren = true;
			mouseEnabled = false;
			_hitTest.alpha = 0;
			addChild(_hitTest);
		}
	}
}