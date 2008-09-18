import prototypes.*

dynamic class prototypes.XMLNodePrototype
{
	//-------------------------------------------------------------------
	//	CLASS METHOD API
	//-------------------------------------------------------------------
	
	static function include( propertyName:String )
	{
		var instance = new XMLNodePrototype()
		if( !instance[propertyName])
		{
			trace( "XMLNodePrototype does not contain the "+propertyName+" property" )
		}
		else
		{
			XMLNode.prototype[propertyName] = instance[propertyName]
		}
	}
	
	static function includeAll()
	{
		Prototype.includeClass( XMLNodePrototype, XMLNode )
	}
	
	static function revertAll()
	{
		Prototype.revertClass( XMLNodePrototype, XMLNode )
	}
	
	//-------------------------------------------------------------------
	//	PROTOTYPE METHODS
	//-------------------------------------------------------------------
	
	function __resolve( name:String ):XMLNode
	{
		var l = this.childNodes.length;
		for( var i=0; i<l; i++ )
		{
			if( this.childNodes[i].nodeName == name )
			{
				this[name] = this.childNodes[i];
				return this.childNodes[i];
			}
		}
	}
}