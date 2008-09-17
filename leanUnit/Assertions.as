import leanUnit.*

class leanUnit.Assertions
{
	var className:String
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
			Output.addSuccess()
		}
		else
		{
			Output.addFail()
			failures.push(new Failure(className, currentMethod, message))
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

	function assertNotUndefined(object, message)
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
}