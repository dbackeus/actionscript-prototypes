import prototypes.*

/**
Extends the core functionality of Number. Note that you have to wrap your number in parenthesis if you haven't assigned to a variable to avoid the compiler throwing syntax error.

@example
<code>
3.days.fromNow // Syntax error
(3).days.fromNow // Works

n = 3
n.days.fromNow // Works
</code>
*/

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
	
	/**
	Generates a date object from the number as milliseconds subtracted from current time. Should be used with the other time shortcuts like in the example.
	
	@returns a date object
	@example
	<code>
	trace( (2).days.ago ) // A Date object with the time set to 2 days ago
	</code>
	*/
	
	function get ago():Date
	{
		var d = new Date()
		return new Date( d.valueOf() - this )
	}
	
	/**
	Generates a date object from the number as milliseconds added to current time. Should be used with the other time shortcuts like in the example.
	
	@returns a date object
	@example
	<code>
	trace( (3).hours.fromNow ) // A Date object with the time set to 3 hours from current time
	</code>
	*/
	
	function get fromNow():Date
	{
		var d = new Date()
		return new Date( d.valueOf() + this )
	}
	
	/**
	Returns true if number is even.
	
	@returns true or false
	@example
	<code>
	trace( (24).isEven ) // true
	trace( (15).isEven ) // false
	</code>
	*/
	
	function get isEven():Boolean
	{
		return (this % 2 == 0)
	}
	
	/**
	Returns true if number is odd.
	
	@returns true or false
	@example
	<code>
	trace( (13).isOdd ) // true
	trace( (44).isOdd ) // false
	</code>
	*/
	
	function get isOdd():Boolean
	{
		return (this % 2 != 0)
	}
	
	/**
	Rounds the number to nearest integer. Rounds up if number is .5.
	
	@returns an integer
	@example
	<code>
	trace( (1.4).round() ) // 1
	trace( (1.5).round() ) // 2
	trace( (1.8).round() ) // 2
	</code>
	*/
	function round():Number
	{
		return Math.round(this)
	}
	
	/**
	Returns the nearest integer that is higher than or equal to the number.
	
	@returns an integer
	@example
	<code>
	trace( (1.0).ceil() ) // 1
	trace( (1.3).ceil() ) // 2
	</code>
	*/
	
	function ceil():Number
	{
		return Math.ceil(this)
	}
	
	/**
	Returns the nearest integer that is less than or equal to the number.
	
	@returns an integer
	@example
	<code>
	trace( (1.0).floor() ) // 1
	trace( (1.9).floor() ) // 1
	</code>
	*/
	
	function floor():Number
	{
		return Math.floor(this)
	}
}