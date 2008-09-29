import prototypes.*

class prototypes.Prototype
{
	/**
	Use this to initialize all prototypes. A good idea is to make sure this function runs before any of your other classes instantiate, for example in a framescript before any movieclips have been put on stage. Includes all functionality from all XxxPrototype classes.
	
	If you want to include only functions from a particular Prototype class you can call includeAll() on that particular class.
	
	@returns nothing
	@example
	<code>
	import prototypes.*
	
	Prototype.includeAll() // You're now good to go!
	</code>
	*/
	
	static function includeAll()
	{
		ArrayPrototype.includeAll()
		MovieClipPrototype.includeAll()
		NumberPrototype.includeAll()
		ObjectPrototype.includeAll()
		StringPrototype.includeAll()
		XMLNodePrototype.includeAll()
	}
	
	/**
	If you only want to use the prototypes in some part of your application you can revert all the functionality through this function. Removes all functionality added by the XxxPrototype classes.
	
	@returns nothing
	@example
	<code>
	import prototypes.*
	
	Prototype.includeAll() // Now you're playing with power!
	
	// Do awesome stuff...
	
	Prototype.revertAll() // Now you're a sad panda :(
	</code>
	*/
	
	static function revertAll()
	{
		ArrayPrototype.revertAll()
		MovieClipPrototype.revertAll()
		NumberPrototype.revertAll()
		ObjectPrototype.revertAll()
		StringPrototype.revertAll()
		XMLNodePrototype.revertAll()
	}
	
	/**
	@exclude
	*/
	static function includeClass( prototypeClass, targetClass )
	{
		_global.ASSetPropFlags(prototypeClass.prototype, null, 6, true);
		var instance = new prototypeClass()
		for( var propertyName in instance )
		{
			if( isCustomProperty(propertyName) )
			{
				if( propertyName.indexOf('__get__') == 0 )
				{
					var realName = propertyName.substr(7)
				  targetClass.prototype.addProperty(realName, instance[propertyName], null)
				}
				else
				{
					targetClass.prototype[propertyName] = instance[propertyName]
				}
			}
		}
	}
	
	/**
	@exclude
	*/
	static function revertClass( prototypeClass, targetClass )
	{
		_global.ASSetPropFlags(prototypeClass.prototype, null, 6, true);
		var instance = new prototypeClass()
		for( var propertyName in instance )
		{
			if( isCustomProperty(propertyName) )
			{
				delete targetClass.prototype[propertyName]
			}
		}
	}
	
	/**
	@exclude
	*/
	static function isCustomProperty( propertyName )
	{
		return propertyName != '__proto__' && propertyName != 'constructor'
	}
	
}