import prototypes.*

class test.XMLNodePrototypeTest extends leanUnit.TestCase
{
	function setup()
	{
		XMLNodePrototype.includeAll()
	}
	
	function testResolve()
	{
		var xml = new XML('<root><child><baby value="test" /></child></root>')
		assertEqual( 'test', xml.root.child.baby.attributes.value )
	}
}