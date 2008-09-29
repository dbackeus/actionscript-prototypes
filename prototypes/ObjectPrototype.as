import prototypes.*

dynamic class prototypes.ObjectPrototype
{
	//-------------------------------------------------------------------
	//	CLASS METHOD API
	//-------------------------------------------------------------------
	
	static function include( propertyName:String )
	{
		var instance = new ObjectPrototype()
		if( !instance[propertyName])
		{
			trace( "ObjectPrototype does not contain the "+propertyName+" property" )
		}
		else
		{
			Object.prototype[propertyName] = instance[propertyName]
		}
	}
	
	static function includeAll()
	{
		Prototype.includeClass( ObjectPrototype, Object )
	}
	
	static function revertAll()
	{
		Prototype.revertClass( ObjectPrototype, Object )
	}
	
	//-------------------------------------------------------------------
	//	PROTOTYPE METHODS
	//-------------------------------------------------------------------
	
	/**
	Attempts to make a number out of the object and return it.
	
	@returns a number (or NaN if conversion fails)
	@example
	<code>
	"34.6".toNumber() // 34.6
	"a43.2".toNumber() // NaN
	</code>
	*/
	
	function toNumber()
	{
		return Number(this)
	}
	
	/**
	Attempts to make an integer out of the object and return it.
	
	@returns a number (or NaN if conversion fails)
	@example
	<code>
	"34.5".toInt() // 35
	"34.3".toInt() // 34
	"3f4".toInt() // NaN
	</code>
	*/
	function toInt()
	{
		return int(this)
	}
	
	/**
	Returns the object and all its properties as a string looking much like JSON. Handy for debugging.
	
	@returns a string
	@example
	<code>
	var person = { name:"Julie", age:26 }
	person.toString = function() { return this.name }

	trace( person.inspect() )
	
	// Julie {
	//	toNumber: [type Function]
	//	toInt: [type Function]
	//	inspect: [type Function]
	//	toString: [type Function]
	//	name: Julie
	//	age: 26
	// }
	
	</code>
	*/
	function inspect():String
	{
		var s = this.toString()+" {\n"
		for( var p in this )
		{
			s += "\t"+p+": "+this[p]+"\n"
		}
		s += "}"
		return s
	}
	
}