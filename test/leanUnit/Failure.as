class leanUnit.Failure
{
	var method:String
	var message:String
	
	//-------------------------------------------------------------------
	//	CONSTRUCTOR
	//-------------------------------------------------------------------

	function Failure(method, message)
	{
		this.method = method
		this.message = message
	}
	
	//-------------------------------------------------------------------
	//	PUBLIC FUNCTIONS
	//-------------------------------------------------------------------
	
	function toString()
	{
		return method+": "+message
	}
	
}