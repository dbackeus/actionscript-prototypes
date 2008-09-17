import prototypes.*

class test.MovieClipPrototypeTest extends leanUnit.TestCase
{
	var instance
	var instanceWidth = 400
	var instanceHeight = 300
	
	function setup()
	{
		instance = _root.createEmptyMovieClip( 'mc', 1 )
		instance.beginFill(0x000000)
		instance.lineTo(instanceWidth, 0)
		instance.lineTo(instanceWidth, instanceHeight)
		instance.lineTo(0, instanceHeight)
		instance.endFill()
		
		MovieClipPrototype.includeAll()
	}
	
	function testCenterX()
	{
		var expected = (Stage.width/2) - (instance._width/2)
		assertEqual( expected, instance.centerX )
	}
	
	function testCenterY()
	{
		var expected = (Stage.height/2) - (instance._height/2)
		assertEqual( expected, instance.centerY )
	}
	
	function testDrawRectangle()
	{
		var width = 100
		var height = 100
		
		instance.clear()
		instance.drawRectangle(width, height)
		
		assertEqual( width, instance._width )
		assertEqual( height, instance._height )
	}
	
	function testTrueWidth()
	{
		instance._xscale = 45
		instance._yscale = 50
		
		assertEqual( instanceWidth, instance.trueWidth )
	}

	function testTrueHeight()
	{
		instance._xscale = 45
		instance._yscale = 50

		assertEqual( instanceHeight, instance.trueHeight )
	}
	
	function testButtonFix()
	{
		instance.buttonFix()
		instance.onPress()
		
		assertFalse( instance._focusrect )
		assertEqual( String(instance), String(Selection.getFocus()) )
	}
	
	function teardown()
	{
		instance.removeMovieClip()
	}
}