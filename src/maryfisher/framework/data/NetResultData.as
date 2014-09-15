package maryfisher.framework.data 
{
	/**
     * ...
     * @author maryfisher
     */
    public class NetResultData 
    {
        public var result:Object;
        public var message:String;
        public var isSuccess:Boolean;
        
        public function NetResultData(isSuccess:Boolean, result:Object = null, message:String = "") 
        {
            this.result = result;
            this.message = message;
            this.isSuccess = isSuccess;
            
        }
        
    }

}