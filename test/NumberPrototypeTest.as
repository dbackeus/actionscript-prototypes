import prototypes.*

class test.NumberPrototypeTest extends leanUnit.TestCase
{
	var number
	
	function setup()
	{
		NumberPrototype.includeAll()
	}
	
	function testSeconds()
	{
		var n = 1
		assertEqual( 1000, n.seconds )
		assertEqual( 1000, n.second )
	}
	
	function testMinutes()
	{
		assertEqual( false, true )
	}
	
	function testHours()
	{
		
	}
	
	function testDays()
	{
		
	}
	
	function testWeeks()
	{
		
	}
	
	function testYears()
	{
		
	}
	
}