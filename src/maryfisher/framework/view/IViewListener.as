package maryfisher.framework.view {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IViewListener extends IEventListener, IDisplayObject{
		
		
		function get stageMouseX():Number;
		function get stageMouseY():Number;
		
		function get hasStage():Boolean;
		function hasStageListener(type:String):Boolean
		function addStageListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
		function removeStageListener(type:String, listener:Function, useCapture:Boolean = false) : void;
	}
	
}