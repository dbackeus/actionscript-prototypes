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

	function get seconds()
	{
		return 1000 * this
	}
	function get second() { return this.seconds }
	

}