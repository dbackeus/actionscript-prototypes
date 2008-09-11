import leanUnit.*

class leanUnit.Assertions
{
	var currentMethod:String
	
	var assertionCount:Number
	
	var failures:Array
	
	//-------------------------------------------------------------------
	//	PUBLIC METHODS
	//-------------------------------------------------------------------
	
	function assert(truth, message)
	{
		message = message || 'Expected '+truth+'to be true'
		assertionCount += 1
		if( truth )
		{
			epicSuccess()
		}
		else
		{
			epicFail( message )
		}
	}

	function assertEqual(expected, actual, message)
	{
		message = mergeMessages(message, "Expected "+expected+", not "+actual)
		assert( expected === actual, message )
	}
	
	function assertNull(object, message)
	{
		message = mergeMessages(message, "Expected "+object+" to be nil")
		assert( object === null, message )
	}

	function assertNotNull(object, message)
	{
		message = mergeMessages(message, "Expected "+object+" to not be nil")
		assert( object !== null, message )
	}
	
	function assertUndefined(object, message)
	{
		message = mergeMessages(message, "Expected "+object+" to be undefined")
		assert( object === undefined, message )
	}

	function asserNotUndefined(object, message)
	{
		message = mergeMessages(message, "Expected "+object+" to not be undefined")
		assert( object !== undefined, message )
	}
	
	function assertFalse(object, message)
	{
		message = mergeMessages(message, "Expected "+object+" to be false")
		assert( !object, message )
	}
	
	function assertTrue(object, message)
	{
		message = mergeMessages(message, "Expected "+object+" to be true")
		assert( object, message )
	}
	
	function fail(message)
	{
		message = message || 'Epic fail!'
		assert(false, message)
	}
	
	//-------------------------------------------------------------------
	//	PRIVATE METHODS
	//-------------------------------------------------------------------
	
	private function mergeMessages(message, defaultMessage)
	{
		if( message )
		{
			if( defaultMessage) message += " | "+defaultMessage
		}
		else
		{
			message = defaultMessage
		}
		return message
	}
	
	private function epicSuccess()
	{
		Output.write( "." )
	}
	
	private function epicFail(message)
	{
		Output.write( "F", 'fail' )
		failures.push(new Failure(currentMethod, message))
	}
}