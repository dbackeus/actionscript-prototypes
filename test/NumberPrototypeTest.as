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
		assertEqual( n.seconds, n.second )
	}
	
	function testMinutes()
	{
		var n = 1
		assertEqual( 60000, n.minutes )
		assertEqual( n.minutes, n.minute )
	}
	
	function testHours()
	{
		var n = 1
		assertEqual( 3600000, n.hours )
		assertEqual( n.hours, n.hour )
	}
	
	function testDays()
	{
		var n = 1
		assertEqual( 86400000, n.days )
		assertEqual( n.days, n.day )
	}
	
	function testWeeks()
	{
		var n = 1
		assertEqual( 604800000, n.weeks )
		assertEqual( n.weeks, n.week )
	}
	
	function testAgo()
	{
		fail( "How to test ago?")
	}
	
	function testFromNow()
	{
		fail( "How to test from now?" )
	}
	
	function testIsEven()
	{
		var n = 1
		assertFalse( n.isEven )
		
		n = 2
		assertTrue( n.isEven )
	}
	
	function testIsOdd()
	{
		var n = 1
		assertTrue( n.isOdd )
		
		n = 2
		assertFalse( n.isOdd )
	}
	
	function testRound()
	{
		var n = 1.5
		assertEqual( 2, n.round() )
		
		n = 1.4
		assertEqual( 1, n.round() )
	}
	
	function testCeil()
	{
		var n = 1.3
		assertEqual( 2, n.ceil() )
	}
	
	function testFloor()
	{
		var n = 1.7
		assertEqual( 1, n.floor() )
	}
	
}