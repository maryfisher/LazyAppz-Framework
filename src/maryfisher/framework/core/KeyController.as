package maryfisher.framework.core {
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import maryfisher.framework.data.KeyComboData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class KeyController {
		
		private var _keyUp:Dictionary;
		private var _keyDown:Dictionary;
		private var _keyCombos:Dictionary;
		private var _keysPressed:Vector.<int>;
		private var _keysDeactivated:Vector.<int>;
		//private var _preventDefault:Vector.<int>;
		
		private var _stage:Stage;
		
		private static var _allowInstantiation:Boolean = false;
		private static var _instance:KeyController;
		
		public function KeyController() {
			if (!_allowInstantiation) {
				throw new Error("Nope, this is a Singleton!");
				return;
			}
			
			//_preventDefault = new Vector.<int>();
		}
		
		//public function preventKeys(key:int):void {
			//
		//}
		
		public static function init(stage:Stage):void {
			getInstance()._stage = stage;
			_instance.activate();
		}
		
		public static function getInstance():KeyController {
			if (!_instance) {
				_allowInstantiation = true;
				_instance = new KeyController();
				_allowInstantiation = false;
			}
			
			return _instance;
		}
		
		static public function hasKeyDown(key:int):Boolean {
			return getInstance()._keysPressed.indexOf(key) != -1;
		}
		
		static public function triggerKey(key:int, eventType:String = KeyboardEvent.KEY_UP):void {
			if (eventType == KeyboardEvent.KEY_UP) {
				getInstance().dispatchKeyUp(key);
			}else if (eventType == KeyboardEvent.KEY_DOWN) {
				getInstance().dispatchKeyDown(key);
			}
		}
		
		protected function handleKeyDown(event:KeyboardEvent):void {
			//event.preventDefault();
			dispatchKeyDown(event.keyCode);
		}
		
		protected function handleKeyUp(event:KeyboardEvent):void {
			//event.preventDefault();
			dispatchKeyUp(event.keyCode);
		}
		
		public function registerForKeyUp(keyListener:IKeyListener, keys:Vector.<int>):void {
			if (!_keyUp) _keyUp = new Dictionary(true);
			for each(var key:int in keys) {
				if (!_keyUp[key]) _keyUp[key] = new Vector.<IKeyListener>;
				var vec:Vector.<IKeyListener> = _keyUp[key];
				if (vec.indexOf(keyListener) == -1) {
					vec.push(keyListener);
				}
			}
		}
		
		public function unregisterForKeyUp(keyListener:IKeyListener, keys:Vector.<int>):void {
			var l:int = keys.length;
			for (var i:int = 0; i < l; i++) {
				var vec:Vector.<IKeyListener> = _keyUp[keys[i]];
				if (!vec) return;
				var index:int = vec.indexOf(keyListener);
				if(index > -1)
					vec.splice(index, 1);
			}
		}
		
		public function registerForKeyDown(keyListener:IKeyListener, keys:Vector.<int>):void {
			if (!_keyDown) _keyDown = new Dictionary(true);
			for each(var key:int in keys) {
				if (!_keyDown[key]) _keyDown[key] = new Vector.<IKeyListener>;
				var vec:Vector.<IKeyListener> = _keyDown[key];
				if (vec.indexOf(keyListener) == -1) {
					vec.push(keyListener);
				}
			}
		}
		
		public function unregisterForKeyDown(keyListener:IKeyListener, keys:Vector.<int>):void {
			var l:int = keys.length;
			for (var i:int = 0; i < l; i++) {
				var vec:Vector.<IKeyListener> = _keyDown[keys[i]];
				vec.splice(vec.indexOf(keyListener), 1);
			}
		}
		
		public function registerForKeyCombo(keycombo:KeyComboData):void {
			
			if (!_keyCombos) _keyCombos = new Dictionary(true);
			
			for each (var key:int in keycombo.keys) {
				if (!_keyCombos[key]) _keyCombos[key] = new Vector.<KeyComboData>;
				_keyCombos[key].push(keycombo);
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
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			_stage.removeEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		}
		
		public function activate():void {
			_keysPressed = new Vector.<int>();
			_keysDeactivated = new Vector.<int>();
			_keyCombos = new Dictionary();
			_keyDown = new Dictionary();
			_keyUp = new Dictionary();
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		}
		
		private function dispatchKeyDown(key:int):void {
			if (_keysDeactivated.indexOf(key) == -1) {
				if (_keysPressed.indexOf(key) == -1) _keysPressed.push(key); 
				
				var vec:Vector.<IKeyListener> = _keyDown[key];
				if (vec != null) {
					
					for each(var keyListener:IKeyListener in vec) {
						keyListener.handleKeyDown(key);
					}
				}
				
				var vecC:Vector.<KeyComboData> = _keyCombos[key];//_keyDown[key];
				if (vecC != null) {
					var hasAll:Boolean = true;
					for each(var combo:KeyComboData in vecC) {
						for each(var key1:int in combo.keys) {
							if (_keysPressed.indexOf(key1) == -1) {
								hasAll = false;
								break;
							}
						}
						if (hasAll) {
							combo.listener.handleKeyCombo(combo);
						}
					}
				}
			}
		}
		
		private function dispatchKeyUp(key:int):void {
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
	}

}