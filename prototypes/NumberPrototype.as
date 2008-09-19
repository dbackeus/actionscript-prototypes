import prototypes.*

dynamic class prototypes.NumberPrototype extends Number // Extend thing is a stupid hack to reassure MTASC that 'this' is a Number
{
	//-------------------------------------------------------------------
	//	CLASS METHOD API
	//-------------------------------------------------------------------
	
	static function include( propertyName:String )
	{
		var instance = new NumberPrototype()
		if( !instance[propertyName])
		{
			trace( "NumberPrototype does not contain the "+propertyName+" property" )
		}
		else
		{
			Number.prototype[propertyName] = instance[propertyName]
		}
	}
	
	static function includeAll()
	{
		Prototype.includeClass( NumberPrototype, Number )
	}
	
	static function revertAll()
	{
		Prototype.revertClass( NumberPrototype, Number )
	}
	
	//-------------------------------------------------------------------
	//	PROTOTYPE METHODS
	//-------------------------------------------------------------------

	function get seconds():Number
	{
		return this * 1000
	}
	function get second():Number { return this.seconds }
	
	function get minutes():Number
	{
		return this * 1000 * 60
	}
	function get minute():Number { return this.minutes }
	
	function get hours():Number
	{
		return this * 1000 * 60 * 60
	}
	function get hour():Number { return this.hours }
	
	function get days():Number
	{
		return this * 1000 * 60 * 60 * 24
	}
	function get day():Number { return this.days }
	
	function get weeks():Number
	{
		return this * 1000 * 60 * 60 * 24 * 7
	}
	function get week():Number { return this.weeks }
	
	function get ago():Date
	{
		var d = new Date()
		return new Date( d.valueOf() - this )
	}
	
	function get fromNow():Date
	{
		var d = new Date()
		return new Date( d.valueOf() + this )
	}
	
	function get isEven():Boolean
	{
		return (this % 2 == 0)
	}
	
	function get isOdd():Boolean
	{
		return (this % 2 != 0)
	}
	
	function round():Number
	{
		return Math.round(this)
	}
	
	function ceil():Number
	{
		return Math.ceil(this)
	}
	
	function floor():Number
	{
		return Math.floor(this)
	}
}