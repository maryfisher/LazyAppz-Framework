package maryfisher.framework.components {
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TextButton extends SpriteButton {
		
		protected var _label:TextField;
		
		protected var _overColor:uint;
		protected var _upColor:uint;
		protected var _downColor:uint;
		
		protected var _textFormat:TextFormat;
		
		private var _hasOver:Boolean = false;
		private var _hasDown:Boolean = false;
		
		public function TextButton(id:String) {
			super(id);
			_label = new TextField();
			_label.wordWrap = false;
			_label.autoSize = TextFieldAutoSize.CENTER;
			addChild(_label);
		}
		
		protected function set textColor(color:uint):void {
			_label.textColor = color;
		}
		
		override protected function handleMouseOver(e:MouseEvent):void {
			super.handleMouseOver(e);
			if(_hasOver) _label.textColor = _overColor;
			
		}
		
		override protected function handleMouseOut(e:MouseEvent):void {
			super.handleMouseOut(e);
			_label.textColor = _upColor;
		}
		
		override protected function handleMouseDown(e:MouseEvent):void {
			super.handleMouseDown(e);
			if(_hasDown) _label.textColor = _downColor;
		}
		
		override protected function handleMouseUp(e:MouseEvent):void {
			super.handleMouseUp(e);
			_label.textColor = _upColor;
		}
		
		//pro function set overColor(value:uint):void {
			//_overColor = value;
		//}
		//
		//public function set upColor(value:uint):void {
			//_upColor = value;
		//}
		
		protected function set hasOver(value:Boolean):void {
			_hasOver = value;
		}
		
		protected function set hasDown(value:Boolean):void {
			_hasDown = value;
		}
		
		public function set label(value:String):void {
			_label.text = value;
		}
		
		public function get label():String {
			return _label.text;
		}
		
		public function set textFormat(value:TextFormat):void {
			_textFormat = value;
			_label.defaultTextFormat = _textFormat;
			_label.setTextFormat(_textFormat);
		}
	}

}