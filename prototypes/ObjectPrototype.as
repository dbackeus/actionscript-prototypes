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
	
	function toNumber()
	{
		return Number(this)
	}
	
	function toInt()
	{
		return int(this)
	}
	
	function inspect()
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