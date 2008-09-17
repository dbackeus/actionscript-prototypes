class leanUnit.Failure
{
	var className:String
	var method:String
	var message:String
	
	//-------------------------------------------------------------------
	//	CONSTRUCTOR
	//-------------------------------------------------------------------

	function Failure(className, method, message)
	{
		this.className = className
		this.method = method
		this.message = message
	}
	
	//-------------------------------------------------------------------
	//	PUBLIC FUNCTIONS
	//-------------------------------------------------------------------
	
	function toString()
	{
		return className+"#"+method+" - "+message
	}
	
}