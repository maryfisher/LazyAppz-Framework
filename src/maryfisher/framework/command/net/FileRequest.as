package maryfisher.framework.command.net {
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import maryfisher.framework.data.NetData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class FileRequest extends NetRequest {
		
		static public const FILE_JPG:String = ".jpg";
		static public const FILE_TXT:String = ".txt";
		static public const FILE_XML:String = ".xml";
		
		protected var _pathPrefix:String;
		protected var _pathSuffix:String = "";
		private var _file:File;
		private var _baseFile:File;
		private var _fileStream:FileStream;
		
		public function FileRequest() {
			super();
			
		}
		
		protected function browseForSave(path:String):void {
			createFile(path)
			_file.addEventListener(Event.SELECT, onFileSelected);
			_file.browseForSave("Save Your File");
		}
		
		protected function onFileSelected(e:Event):void {
			
		}
		
		protected function readXML(fileName:String):XML {
			openFile(fileName, FileMode.UPDATE);
			var xml:XML = XML(_fileStream.readUTFBytes(_fileStream.bytesAvailable));
			_fileStream.close();
			return xml;
		}
		
		protected function writeBytes(fileName:String, ba:ByteArray):void {
			openFile(fileName, FileMode.WRITE);
			_fileStream.writeBytes(ba);
			_fileStream.close();
		}
		
		protected function writeUTFBytes(fileName:String, str:String):void {
			openFile(fileName, FileMode.WRITE);
			_fileStream.writeUTFBytes(str);
			_fileStream.close();
		}
		
		private function openFile(fileName:String, mode:String):void {
			createFile(fileName);
			_fileStream = new FileStream();
			_fileStream.open(_file, mode);
		}
		
		private function createFile(fileName:String):void {
			var path:String = _baseFile.resolvePath(_pathPrefix + fileName + _pathSuffix).nativePath;
			_file = new File(path);
		}
		
		public function set pathPrefix(value:String):void {
			_pathPrefix = value;
		}
		
		public function set baseFile(value:File):void {
			_baseFile = value;
		}
	}

}