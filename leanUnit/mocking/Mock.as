import leanUnit.mocking.*

// Should error report something like
// Mock 'Class' expected 'foo' with ("bar") once, but received it 0 times

dynamic class leanUnit.mocking.Mock
{
	var expectations:Array
	var stubs:Array
	
	//-------------------------------------------------------------------
	//	CONSTRUCTOR
	//-------------------------------------------------------------------

	function Mock( properties:Object )
	{
		for( var p in properties )
		{
			this[p] = properties[p]
		}
		
		expectations = stubs = new Array()
		
		Mock.instances.push(this)
	}
	
	function expects( methodName:String ):MockMethod
	{
		mockMethod = new MockMethod( methodName, this )
		expectations.push( mockMethod )
		return mockMethod
	}
	
	function stub( methodName:String ):MockMethod
	{
		mockMethod = new MockMethod( methodName )
		stubs.push( mockMethod )
		return mockMethod
	}
	
	//-------------------------------------------------------------------
	//	CLASS METHOD API
	//-------------------------------------------------------------------
	
	static function anyInstanceOf( klass ):ClassMock
	{
		var className:String = Reflection.getClassName( klass )
		
		if( !originalClassStore[className] ) 
		{
			// Store away the original class
			originalClassStore[className] = klass
			
			// Create a new class to replace the real one with which we can mock
			var mockClass = function() {}
			mockClass.prototype.__proto__ = klass.prototype
			
			// Replace the real class
			_global[className] = mockClass
			
			// Create a mock dedicated to instances of the mocked class
			var mock = mockStore[className] = new ClassMock()
			trace( "#Mock# className: "+className+" mockStored: "+mockStore[className] )
			mock.className = className
		}
		
		return mockStore[className]
	}
	
	//-------------------------------------------------------------------
	//	METHOD MISSING (RESOLVE)
	//-------------------------------------------------------------------
	
	// Since __resolve in itself does not handle parameters we have to proxy the call to another handler
	function __resolve( methodName:String )
	{
		return function() 
		{ 
			arguments.unshift(methodName)
			return methodMissing.apply( this, arguments ) 
		}
	}
	
	// Here the arguments will look like: [methodName, arg1, arg2...] which is what we want
	private function methodMissing()
	{
		var methodName = arguments.shift()
		
		var matchingMockWithoutArgumentExpectation
		
		// Iterate all mocked expecations. A matching mock with matching arguments is invoked directly but a matching mock with no argument expectations is stored if no argument matches are found.
		for( var i=0; i<expectations.length; i++ )
		{
			var mock = expectations[i]
			
			if( mock.methodName == methodName )
			{
				if( matchArgs( arguments, mock.args ) )
				{
					return mock.invoke.apply(mock, arguments)
				}
				else
				{
					matchingMockWithoutArgumentExpectation = mock
				}
			}
		}
		
		// Invoe stored mock if it exists
		if( matchingMockWithoutArgumentExpectation )
		{
			return matchingMockWithoutArgumentExpectation.invoke.apply(matchingMockWithoutArgumentExpectation, arguments)
		}
		
		// If no mocks were found dig through the stubs
		for( var i=0; i<stubs.length; i++ )
		{
			var stub = stubs[i]
			if( mock.methodName == methodName )
			{
				return stub.invoke.apply(stub, arguments)
			}
		}
	}
	
	// True if the args are the same as the mock expects
	private function matchArgs( actual:Array, wanted:Array ):Boolean
	{
		for( var i=0; i<actual.length; i++ )
		{
			if( actual[i] !== wanted[i] ) return false
		}
		return true
	}
	
	//-------------------------------------------------------------------
	//	CLASS METHODS
	//-------------------------------------------------------------------
	
	static var _instances:Array
	static function get instances():Array
	{
		if( !_instances )
		{
			_instances = new Array()
		}
		return _instances
	}
	
	static var _originalClassStore:Object
	static function get originalClassStore():Object
	{
		if( !_originalClassStore )
		{
			_originalClassStore = new Object()
		}
		return _originalClassStore
	}
	
	static var _mockStore:Object
	static function get mockStore():Object
	{
		if( !_mockStore )
		{
			_mockStore = new Object()
		}
		return _mockStore
	}
	
	static function reset()
	{
		// TODO: Reset all mocked classes
		for(var p in originalClassStore )
		{
			var originalClass = originalClassStore[p]
			_global[p] = originalClass
		}
		
		delete _originalClassStore
		delete _mockStore
		delete _instances
	}
}