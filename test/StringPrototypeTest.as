import prototypes.*

class test.StringPrototypeTest extends leanUnit.TestCase
{
	function setup()
	{
		StringPrototype.includeAll()
	}
	
	function testReplace()
	{
		var s = "Hello David whats going on David?"
		assertEqual( "Hello Mats whats going on Mats?", s.replace( "David", "Mats") )
	}
	
	function testIncludes()
	{
		var s = "Hello happy man."
		assertTrue( s.includes("Hell") )
		assertTrue( s.includes("happy") )
		assertFalse( s.includes("not_there") )
	}
	
	function testBeginsWith()
	{
		var s = "Hello my son"
		assertTrue( s.beginsWith("Hello") )
		assertFalse( s.beingsWith("son") )
	}
	
	function testEndsWith()
	{
		var s = "Those are some fancy hacking skillz"
		assertTrue( s.endsWith("skillz") )
		assertFalse( s.endsWith("Those") )
	}
	
	function testCapitalize()
	{
		var s = "my little Sentence"
		assertEqual( "My little sentence", s.capitalize() )
	}
	
	function testTitleize()
	{
		var s = "my awesome title"
		assertEqual( "My Awesome Title", s.titleize() )
	}
	
	function testToDate()
	{
		fail("Not implemented")
	}
	
	function testChars()
	{
		var s = "My god."
		assertEqual( 7, s.chars.length )
		assertEqual( "My god.", s.chars.join('') )
		assertEqual( "My god.", s.characters.join('') )
	}
}

/*
var str = sprintf( "%s", tal )

"%s".printf(tal)
*/