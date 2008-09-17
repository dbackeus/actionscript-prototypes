import leanUnit.mocking.*

class leanUnit.mocking.MockMethod
{
	var mock:Mock
	var methodName:String
	var expectedArgs:Array
	var returnValue:Object
	var fakeMethod:Function
	
	var timesExpected:Number
	var timesReceived:Number
	
	//-------------------------------------------------------------------
	//	CONSTRUCTOR
	//-------------------------------------------------------------------

	function MockMethod( methodName, mock )
	{
		this.methodName = methodName
		this.mock = mock
	}
	
	function withArgs()
	{
		expectedArgs = arguments
		return this
	}
	
	function times( number )
	{
		timesExpected = number
		return this
	}
	
	function returns( object )
	{
		returnValue = object
		return this
	}
	
	function runs( f:Function )
	{
		fakeMethod = f
		return this
	}
	
	//-------------------------------------------------------------------
	//	PUBLIC METHODS
	//-------------------------------------------------------------------
	
	function invoke()
	{
		//trace( "#MockMethod# invoking "+methodName+", with: "+arguments )
		timesReceived += 1
		var runResult = fakeMethod.apply(mock, arguments)
		return returnValue || runResult
	}
	
	function verify()
	{
		// If no number of times is set, mock expects to get called at least once
		if( timesExpected == timesReceived || (timesExpected === undefined && timesReceived > 0) )
		{
			return true
		}
		else 
		{
			return errorMessage
		}
	}
	
	function get errorMessage():String
	{
		return "Mock expected '"+methodName+"' with ("+expectedArgs.join(',')+") "+timesExpected+" times but received it "+timesReceived+" times"
	}
}