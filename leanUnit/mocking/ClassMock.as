import leanUnit.mocking.*

/*
  Used when mocking all instances of a class.
	Adds mocked or stubbed methods to the temporary replacement class.
*/

class leanUnit.mocking.ClassMock extends Mock
{
	var className:String
	
	function expects( methodName:String ):MockMethod
	{
		var instance = this
		_global[className].prototype[methodName] = function()
		{
			return instance[methodName].apply(instance, arguments)
		}
		
		return super.expects( methodName )
	}
	
	function stub( methodName:String ):MockMethod
	{
		var instance = this
		_global[className].prototype[methodName] = function()
		{
			return instance[methodName].apply(instance, arguments)
		}
		
		return super.stub( methodName )
	}
}