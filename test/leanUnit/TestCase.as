import leanUnit.*

/*

Scenario:

// StringTest.as
class StringTest extends leanUnit.TestCase
{
	var string:String
	
	function setup()
	{
		string = 'Asdf'
	}
	
	function testLength()
	{
		assertEqual(4, string.length)
	}
	
	function testToUpperCase()
	{
		assertEqual( 'ASDF', string.toUpperCase() )
	}
	
	function teardown()
	{
		delete string
	}
}

// Framescript
new StringTest().run()

*/

class leanUnit.TestCase extends Assertions
{
	private var _testMethods:Array
	private var _timeTaken
	
	var setup:Function
	var teardown:Function
	
	//-------------------------------------------------------------------
	//	PUBLIC METHODS
	//-------------------------------------------------------------------
	
	function run()
	{
		reset()
		
		var startTime = getTimer()
		Output.writeln("Started")
		
		for(var i=0; i<testMethods.length; i++)
		{
			runMethod(testMethods[i])
		}
		var endTime = getTimer() - startTime
		
		Output.writeln()
		Output.writeln('Finished in '+(endTime/1000)+' seconds')
		
		report()
	}
	
	//-------------------------------------------------------------------
	//	PRIVATE METHODS
	//-------------------------------------------------------------------
	
	private function reset()
	{
		failures = new Array()
		assertionCount = 0
	}
	
	private function runMethod(methodName)
	{
		currentMethod = methodName
	
		setup()
		this[methodName]()
		teardown()
	}
	
	private function report()
	{
		for( var i=0; i<failures.length; i++ )
		{
			Output.writeln()
			Output.writeln( (i+1)+")")
			Output.writeln( failures[i], "fail" )
		}
		Output.writeln()
		Output.writeln( testMethods.length+" tests, "+assertionCount+" assertions, "+failures.length+" failures", failures.length > 0 ? 'fail' : 'success' )
	}
	
	//-------------------------------------------------------------------
	//	PROPERTIES
	//-------------------------------------------------------------------
	
	function get testMethods():Array
	{
		if( !_testMethods )
		{
			_testMethods = new Array();

			_global.ASSetPropFlags(this.__proto__, null, 6, true);
			for(var property:String in this) 
			{
				var value = this[property]
				if( property.indexOf("test") == 0 && value instanceof Function )
				{
					_testMethods.push(property)
				}
			}
			_global.ASSetPropFlags(this.__proto__, null, 1, true);
		
			_testMethods.reverse()
		}
		
		return _testMethods
	}
}