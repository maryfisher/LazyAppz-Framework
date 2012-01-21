package maryfisher.framework.core {
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class KeyController{
		protected var _keyUp:Dictionary;
		protected var _keyDown:Dictionary;
		protected var _keyCombo:Dictionary;
		protected var _keysPressed:Vector.<int>;
		protected var _keysDeactivated:Vector.<int>;
		
		protected var _stage:Stage;
		
		protected static var _allowInstantiation:Boolean = false;
		protected static var _instance:KeyController;
		
		public function KeyController() {
			if (!_allowInstantiation) {
				
			}
			//_stage = StageReference.getStage();
		}
		
		public static function init(stage:Stage):void {
			getInstance()._stage = stage;
			
		}
		
		public static function getInstance():KeyController {
			if (_instance == null) {
				_allowInstantiation = true;
				_instance = new KeyController();
				_allowInstantiation = false;
			}
			
			return _instance;
		}
		
		protected function handleKeyDown(event:KeyboardEvent):void {
			trace('keydown ' + event.keyCode);
			
			var key:int = event.keyCode;
			if (_keysDeactivated.indexOf(key) == -1) {
				if (_keysPressed.indexOf(key) == -1) _keysPressed.push(key); 
				
				var vec:Vector.<IKeyListener> = _keyDown[key];
				if (vec != null) {
					
					for each(var keyListener:IKeyListener in vec) {
						if (_keyCombo[keyListener] != null) {
							
							var combo:Vector.<int> = _keyCombo[keyListener];
							if (combo.indexOf(key) > -1) {
								var hasAll:Boolean = true;
								for each(var key1:int in combo) {
									if (_keysPressed.indexOf(key1) == -1) {
										hasAll = false;
										break;
									}
								}
								if (hasAll) {
									keyListener.handleKeyCombo();
								}
							}else {
								keyListener.handleKeyDown(key);
							}
						}else {
							keyListener.handleKeyDown(key);
						}
					}
				}
			}
		}
		
		protected function handleKeyUp(event:KeyboardEvent):void {
			var key:int = event.keyCode;
			if (_keysDeactivated.indexOf(key) == -1) {
				if (_keysPressed.indexOf(key) > -1) _keysPressed.splice(_keysPressed.indexOf(key), 1);
				
				var vec:Vector.<IKeyListener> = _keyUp[key];
				if(vec != null){
					for each(var keyListener:IKeyListener in vec) {
						keyListener.handleKeyUp(key);
					}
				}
			}
		}
		
		public function registerForKeyUp(keyListener:IKeyListener, keys:Vector.<int>):void {
			if (_keyUp == null) _keyUp = new Dictionary(true);
			for each(var key:int in keys) {
				if (_keyUp[key] == null) _keyUp[key] = new Vector.<IKeyListener>;
				var vec:Vector.<IKeyListener> = _keyUp[key];
				if (vec.indexOf(keyListener) == -1) {
					vec.push(keyListener);
				}
			}
		}
		
		public function registerForKeyDown(keyListener:IKeyListener, keys:Vector.<int>):void {
			if (_keyDown == null) _keyDown = new Dictionary(true);
			for each(var key:int in keys) {
				if (_keyDown[key] == null) _keyDown[key] = new Vector.<IKeyListener>;
				var vec:Vector.<IKeyListener> = _keyDown[key];
				if (vec.indexOf(keyListener) == -1) {
					vec.push(keyListener);
				}
			}
		}
		
		public function registerForKeyCombo(keyListener:IKeyListener, keycombo:Vector.<int>):void {
			/* TODO
			 * hier spezifische Combos als Vos, weil eventuell mit mehr als einer combo registriert wird
			 */
			if (_keyCombo == null) _keyCombo = new Dictionary(true);
			if (_keyCombo[keyListener] == null) {
				_keyCombo[keyListener] = keycombo;
				return;
			}
		}
		
		public function partialDeactivate(keysDeactivated:Vector.<int>):void {
			_keysDeactivated = keysDeactivated;
			
		}
		
		public function reset():void {
			_keysDeactivated = null;
		}
		
		public function deactivate():void {
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown, true);
			_stage.removeEventListener(KeyboardEvent.KEY_UP, handleKeyUp, true);
		}
		
		public function activate():void {
			_keysPressed = new Vector.<int>();
			_keysDeactivated = new Vector.<int>();
			_keyCombo = new Dictionary();
			_keyDown = new Dictionary();
			_keyUp = new Dictionary();
			//var stage:Stage = StageReference.getStage();
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown, false, 0, true);
			_stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp, false, 0, true);
		}
		
		//public static function keyTranslator(keycode:int):String {
			//var key:String;
			//
			//switch(keycode) {
				//case Keyboard.DOWN: key = "Backward";
					//break;
				//case Keyboard.UP: key = "Forward";
					//break;
				//case Keyboard.LEFT: key = "Left";
					//break;
				//case Keyboard.RIGHT: key = "Right";
					//break;
				//case Keyboard.PAGE_UP: key = "Up";
					//break;
				//case Keyboard.PAGE_DOWN: key = "Down";
					//break;
				//case Keyboard.NUMPAD_ADD: 
				//case 187:
					//key = "Plus";
					//break;
				//case Keyboard.NUMPAD_SUBTRACT:
				//case 189:
					//key = "Minus";
					//break;
				//default:
					//key = keycode.toString();
			//}
			//
			//return key;
		//}
	}

}