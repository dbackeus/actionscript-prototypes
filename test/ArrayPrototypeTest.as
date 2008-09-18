import prototypes.*

class test.ArrayPrototypeTest extends leanUnit.TestCase
{
	var array:Array
	var persons:Array
	
	function setup()
	{
		array = ['David', 777, 'Erik', 'Jessica', 'Angelica']
		
		persons = [
			{name:"David", age:23},
			{name:"Gabriel", age:5},
			{name:"Ganesha", age:5},
			{name:"Jimmy", age:28}
		]
		
		ArrayPrototype.includeAll()
	}
	
	function testEach()
	{
		fail('how to test each properly?')
	}
	
	function testCollect() 
	{
		var names = persons.collect( function( element ) { return element.name } )
		assertEqual( 'David,Gabriel,Ganesha,Jimmy', names.toString() )		
	}
	
	function testIncludes()
	{
		assertTrue( array.includes('David') )
		assertTrue( array.includes( 777 ) )
		assertFalse( array.includes('not_here') )
	}
	
	function testSelect()
	{
		var adults = persons.select( function(person) { return person.age > 18 } )
		assertEqual( 2, adults.length )
	}
	
	function testSelectByProperty()
	{
		var fiveYearOlds = persons.selectByProperty( "age", 5 )
		assertEqual( 2, fiveYearOlds.length )
	}
	
	function testDetect()
	{
		var david = persons.detect( function(person) { return person.name == 'David' } )
		assertEqual( 'David', david.name )
	}
	
	function testDetectByProperty()
	{
		var firstFiveYearOld = persons.detectByProperty( "age", 5 )
		assertEqual( 'Gabriel', firstFiveYearOld.name )
	}
	
	function testReject()
	{
		var adults:Array = persons.reject( function(person) { return person.age < 18 } )
		assertEqual( 'David', adults[0].name )
		assertEqual( 'Jimmy', adults[1].name )
	}
	
	function testRejectByProperty()
	{
		var everyOneButGanesha:Array = persons.rejectByProperty( 'name', 'Ganesha' )
		assertEqual( 3, everyOneButGanesha.length )
	}
	
	function testRandomize()
	{
		// How to test randomize properly??
	}
}