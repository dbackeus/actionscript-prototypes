import prototypes.*

class prototypes.Prototype
{
	static function includeAll()
	{
		MovieClipPrototype.includeAll()
		ArrayPrototype.includeAll()
	}
	
	static function revertAll()
	{
		MovieClipPrototype.revertAll()
		MovieClipPrototype.revertAll()
	}
	
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
				  MovieClip.prototype.addProperty(realName, instance[propertyName], null)
				}
				else
				{
					MovieClip.prototype[propertyName] = instance[propertyName]
				}
			}
		}
	}
	
	static function revertClass( prototypeClass, targetClass )
	{
		_global.ASSetPropFlags(prototypeClass.prototype, null, 6, true);
		var instance = new prototypeClass()
		for( var propertyName in instance )
		{
			if( isCustomProperty(propertyName) )
			{
				delete MovieClip.prototype[propertyName]
			}
		}
	}
	
	static function isCustomProperty( propertyName )
	{
		return propertyName != '__proto__' || propertyName != 'constructor'
	}
	
}