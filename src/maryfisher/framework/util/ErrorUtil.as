package maryfisher.framework.util {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ErrorUtil {
		
		/** TODO
		 * logging funtionality (text-file instead of or before throwing error)
		 * functionality to switch and not trace but output elsewhere
		 */
		
		static public function notImplemented(className:String = "", methodName:String = ""):void {
			throw new Error("[" + className + "] [" + methodName + "] Is not implemented, yet!");
		}
		
		static public function notTested(className:String = "", methodName:String = ""):void {
			trace("[" + className + "] [" + methodName + "]", "Has not been tested, yet.");
			trace("Please remove if functioning properly!");
		}
		
		static public function somethingWrong(wronged:String, className:String = "", methodName:String = ""):void {
			trace("[" + className + "] [" + methodName + "]", wronged);
		}
		
		static public function error(error:String, className:String = "", methodName:String = ""):void {
			throw new Error("[" + className + "] [" + methodName + "] " + error);
		}
		
	}

}