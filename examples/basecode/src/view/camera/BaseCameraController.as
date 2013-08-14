package view.camera {
	import away3d.containers.ObjectContainer3D;
	import away3d.core.math.MathConsts;
	import away3d.entities.Entity;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import maryfisher.framework.view.ICameraController;
	import maryfisher.framework.view.ICameraObject;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseCameraController implements ICameraController {
		
		private var _currentPositionX:Number = 0;
		private var _currentPositionZ:Number = 0;
		protected var _positionX:Number = 0;
		protected var _positionZ:Number = 0;
		private var _maxPositionX:Number = Infinity;
		private var _minPositionX:Number = -Infinity;
		private var _maxPositionZ:Number = Infinity;
		private var _minPositionZ:Number = -Infinity;
		
		protected var _currentPanAngle:Number = 0;
		protected var _currentTiltAngle:Number = 90;
		protected var _panAngle:Number = 0;
		protected var _tiltAngle:Number = 90;
		private var _minPanAngle:Number = -Infinity;
		private var _maxPanAngle:Number = Infinity;
		private var _minTiltAngle:Number = -80;
		private var _maxTiltAngle:Number = 90;
		
		private var _distance:Number = 1000;
		
		private var _steps:Number = 8;
		private var _yFactor:Number = 2;
		private var _wrapPanAngle:Boolean = false;
		
		private var _moveUpdate:Boolean = false;
		
		private var _tiltSignal:Signal;
		private var _panSignal:Signal;
		private var _cameraObjects:Vector.<ICameraObject>;
		
		protected var _minBoundsX:int;
		protected var _maxBoundsX:int;
		protected var _minBoundsY:int;
		protected var _maxBoundsY:int;
		
		protected var _targetObject:Entity;
		protected var _lookAtObject:ObjectContainer3D;
		protected var _stage:Stage;
		
		private var _cameraBehaviors:Vector.<AbstractCameraBehavior>;
		
		public function BaseCameraController(targetObject:Entity = null, lookAtObject:ObjectContainer3D = null, panAngle:Number = 0, tiltAngle:Number = 90, distance:Number = 1000){
			_targetObject = targetObject;
			_lookAtObject = lookAtObject || new ObjectContainer3D();
			//super(targetObject, lookAtObject);
			
			_distance = distance;
			this.panAngle = panAngle;
			this.tiltAngle = tiltAngle;
			
			_currentPanAngle = _panAngle;
			_currentTiltAngle = _tiltAngle;
			
			_currentPositionX = _lookAtObject.position.x;
			_currentPositionZ = _lookAtObject.position.z;
			
			_tiltSignal = new Signal(int);
			_panSignal = new Signal(int);
			
			_cameraObjects = new Vector.<ICameraObject>();
			_cameraBehaviors = new Vector.<AbstractCameraBehavior>();
			
			updatePosition();
			updateAngle();
			updateLookAt();
		}
		
		public function addBehavior(behav:AbstractCameraBehavior):void {
			_cameraBehaviors.push(behav);
		}
		
		public function assignBounds(minBoundsX:int, maxBoundsX:int, minBoundsY:int, maxBoundsY:int):void {
			_maxBoundsY = maxBoundsY;
			_minBoundsY = minBoundsY;
			_maxBoundsX = maxBoundsX;
			_minBoundsX = minBoundsX;
			
		}
		
		public function setMinMaxAngle(minTiltAngle:Number = 0, maxTiltAngle:Number = 90, minPanAngle:Number = NaN, maxPanAngle:Number = NaN):void {
			this.minPanAngle = minPanAngle || -Infinity;
			this.maxPanAngle = maxPanAngle || Infinity;
			this.minTiltAngle = minTiltAngle;
			this.maxTiltAngle = maxTiltAngle;
		}
		
		public function setMinMaxPos(minPosX:Number, maxPosX:Number, minPosZ:Number, maxPosZ:Number):void {
			_minPositionX = minPosX;
			_maxPositionX = maxPosX;
			_minPositionZ = minPosZ;
			_maxPositionZ = maxPosZ;
		}
		
		/* INTERFACE maryfisher.austengames.view.model3d.core.ICameraController */
		
		public function addTiltListener(listener:Function):void {
			_tiltSignal.add(listener);
		}
		
		public function addPanListener(listener:Function):void {
			_panSignal.add(listener);
		}
		
		public function destroy():void {
			_tiltSignal.removeAll();
			_panSignal.removeAll();
		}
		
		public function start(stage:Stage = null):void {
			_stage = stage || _stage;
			
			for each (var behav:AbstractCameraBehavior in _cameraBehaviors) {
				behav.start(_stage);
			}
			
			_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onEnterFrame(e:Event):void {
			
			for each (var behav:AbstractCameraBehavior in _cameraBehaviors) {
				behav.onEnterFrame(e);
			}
			
			if (_currentPositionX == _positionX && _currentPositionZ == _positionZ) {
				if (_tiltAngle == _currentTiltAngle && _panAngle == _currentPanAngle) {
					return;
				}
			}
			
			
			updatePosition();
			updateAngle();
			updateLookAt();
			updateCameraObjects();
			//if (_currentPositionX != _positionX || _currentPositionZ != _positionZ) {
				//
				//updatePosition();
				//updateLookAt();
				//return;
			//}
			//
			//if (_tiltAngle != _currentTiltAngle || _panAngle != _currentPanAngle) {
				//updateAngle();
				//updateLookAt();
			//}
			
		}
		
		private function updateCameraObjects():void {
			var l:int = _cameraObjects.length;
			for (var i:int = 0; i < l; i++ ) {
				var obj:ICameraObject = _cameraObjects[i];
				obj.cameraPan = _currentPanAngle;
				obj.cameraTilt = _currentTiltAngle;
				obj.setCameraPosition(_targetObject.position, _lookAtObject.position);
			}
		}
		
		public function stop():void {
			
			for each (var behav:AbstractCameraBehavior in _cameraBehaviors) {
				behav.stop();
			}
			
			_stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function updateLookAt():void {
			_targetObject.x = _currentPositionX + _distance * Math.sin(_currentPanAngle * MathConsts.DEGREES_TO_RADIANS) * Math.cos(_currentTiltAngle * MathConsts.DEGREES_TO_RADIANS);
			_targetObject.z = _currentPositionZ + _distance * Math.cos(_currentPanAngle * MathConsts.DEGREES_TO_RADIANS) * Math.cos(_currentTiltAngle * MathConsts.DEGREES_TO_RADIANS);
			_targetObject.y = _lookAtObject.y + _distance * Math.sin(_currentTiltAngle * MathConsts.DEGREES_TO_RADIANS) * _yFactor;
			
			if (_targetObject || _lookAtObject){
				_targetObject.lookAt(_lookAtObject.scene ? _lookAtObject.scenePosition : _lookAtObject.position);
			}
		}
		
		private function updatePosition():void {
			_currentPositionX = _positionX;
			_currentPositionZ = _positionZ;
			
			//_currentPositionX += (_positionX - _currentPositionX)/ (_steps + 1);
			//_currentPositionZ += (_positionZ - _currentPositionZ) / (_steps + 1);
			//
			//snap coords if angle differences are close
			//if (Math.abs(_positionX - _currentPositionX) < 0.01) {
				//_currentPositionX = _positionX;
			//}
			//if(Math.abs(_positionZ - _currentPositionZ) < 0.01) {
				//_currentPositionZ = _positionZ;
			//}
		}
		
		private function updateAngle():void {
			if (_wrapPanAngle) {
				if (_panAngle < 0)
					panAngle = (_panAngle % 360) + 360;
				else
					panAngle = _panAngle % 360;
				
				if (panAngle - _currentPanAngle < -180)
					panAngle += 360;
				else if (panAngle - _currentPanAngle > 180)
					panAngle -= 360;
			}
			
			_currentTiltAngle += (_tiltAngle - _currentTiltAngle)/(_steps + 1);
			_currentPanAngle += (_panAngle - _currentPanAngle)/(_steps + 1);
			
			//snap coords if angle differences are close
			if ((Math.abs(_tiltAngle - _currentTiltAngle) < 0.01) && (Math.abs(_panAngle - _currentPanAngle) < 0.01)) {
				_currentTiltAngle = _tiltAngle;
				_currentPanAngle = _panAngle;
			}
		}
		
		public function set panAngle(val:Number):void {
			val = Math.max(_minPanAngle, Math.min(_maxPanAngle, val));
			
			if (_panAngle == val)
				return;
			
			_panAngle = val;
		}
		
		public function set tiltAngle(val:Number):void {
			val = Math.max(_minTiltAngle, Math.min(_maxTiltAngle, val));
			
			if (_tiltAngle == val)
				return;
			
			_tiltAngle = val;
		}
		
		public function set distance(val:Number):void {
			if (_distance == val)
				return;
			
			_distance = val;
			
			updateLookAtObject();
		}
		
		public function get distance():Number {
			return _distance;
		}
		
		public function set minPanAngle(val:Number):void {
			if (_minPanAngle == val)
				return;
			
			_minPanAngle = val;
			
			panAngle = Math.max(_minPanAngle, Math.min(_maxPanAngle, _panAngle));
		}
		
		public function set maxPanAngle(val:Number):void {
			if (_maxPanAngle == val)
				return;
			
			_maxPanAngle = val;
			
			panAngle = Math.max(_minPanAngle, Math.min(_maxPanAngle, _panAngle));
		}
		
		public function set minTiltAngle(val:Number):void {
			if (_minTiltAngle == val)
				return;
			
			_minTiltAngle = val;
			
			tiltAngle = Math.max(_minTiltAngle, Math.min(_maxTiltAngle, _tiltAngle));
		}
		
		public function set maxTiltAngle(val:Number):void {
			if (_maxTiltAngle == val)
				return;
			
			_maxTiltAngle = val;
			
			tiltAngle = Math.max(_minTiltAngle, Math.min(_maxTiltAngle, _tiltAngle));
		}
		
		public function get panAngle():Number {
			return _panAngle;
		
		}
		
		public function set positionX(value:Number):void {
			if (_positionX == value)
				return;
			
			_positionX = value;
			
			_positionX = Math.max(_minPositionX, Math.min(_maxPositionX, _positionX));
		}
		
		public function set positionZ(value:Number):void {
			if (_positionZ == value)
				return;
			
			_positionZ = value;
			
			_positionZ = Math.max(_minPositionZ, Math.min(_maxPositionZ, _positionZ));
		}
		
		public function get tiltAngle():Number {
			return _tiltAngle;
		}
		
		public function get currentPanAngle():Number {
			return _currentPanAngle;
		}
		
		public function get currentTiltAngle():Number {
			return _currentTiltAngle;
		}
		
		public function get lookAtObject():ObjectContainer3D {
			return _lookAtObject;
		}
		
		public function get targetObject():Entity {
			return _targetObject;
		}
		
		public function moveLookAtObjectTo(pos:Vector3D):void {
			_lookAtObject.position = pos.clone();
			updateLookAtObject();
		}
		
		public function moveLookAtObject(pos:Vector3D):void {
			_lookAtObject.position = _lookAtObject.position.add(pos);
			updateLookAtObject();
		}
		
		public function updateLookAtObject():void {
			_positionX = _lookAtObject.x;
			_positionZ = _lookAtObject.z;
			updatePosition();
			updateAngle();
			updateLookAt();
			updateCameraObjects();
		}
		
		/* INTERFACE maryfisher.view.model3d.ICameraController */
		
		public function registerCameraObject(co:ICameraObject):void {
			_cameraObjects.push(co);
			co.cameraPan = _currentPanAngle;
			co.cameraTilt = _currentTiltAngle;
			co.setCameraPosition(_targetObject.position, _lookAtObject.position);
		}
		
		public function unregisterCameraObject(co:ICameraObject):void {
			_cameraObjects.splice(_cameraObjects.indexOf(co), 1);
		}
	}

}