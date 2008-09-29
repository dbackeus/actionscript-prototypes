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
	
	/**
	Rescues all undefined calls to a node and attempts to find a child node corresponding to the name of the property. This gives you quite an intuitive way to crawl through your xml objects.
	
	@returns a child node (or undefined if none exists)
	@example
	<code>
	var xml = new XML('<root><child><baby value="test" /></child></root>')
	
	trace( xml.root.child.baby.attributes.value ) // "test"
	</code>
	*/
	
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