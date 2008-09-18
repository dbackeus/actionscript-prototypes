import prototypes.*

class test.ObjectPrototypeTest extends leanUnit.TestCase
{
	function setup()
	{
		ObjectPrototype.includeAll()
	}
	
	function testToNumber()
	{
		var s = "234"
		assertEqual( 234, s.toNumber() )
	}
	
	function testToInt()
	{
		var s = '234.54'
		assertEqual( 234, s.toInt() )
		
		var f = 234.54
		assertEqual( 234, f.toInt() )
	}
	
	function testEachProperty()
	{
		fail('How to test eachProperty properly?')
	}
	
	function testInspect()
	{
		var object = new Object()
		object.string = "hello"
		object.number = 123
		
		var inspect = object.inspect()
		
		assertTrue( inspect.indexOf('string') > 0 )
		assertTrue( inspect.indexOf('hello') > 0 )
		assertTrue( inspect.indexOf('number') > 0 )
		assertTrue( inspect.indexOf('123') > 0 )
	}
}