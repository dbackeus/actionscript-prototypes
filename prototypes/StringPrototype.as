import prototypes.*

dynamic class prototypes.StringPrototype extends String
{
	//-------------------------------------------------------------------
	//	CLASS METHOD API
	//-------------------------------------------------------------------
	
	static function include( propertyName:String )
	{
		var instance = new StringPrototype()
		if( !instance[propertyName])
		{
			trace( "StringPrototype does not contain the "+propertyName+" property" )
		}
		else
		{
			String.prototype[propertyName] = instance[propertyName]
		}
	}
	
	static function includeAll()
	{
		Prototype.includeClass( StringPrototype, String )
	}
	
	static function revertAll()
	{
		Prototype.revertClass( StringPrototype, String )
	}
	
	//-------------------------------------------------------------------
	//	PROTOTYPE METHODS
	//-------------------------------------------------------------------
	
	function replace( string:String, withString:String ):String
	{
		return this.split( string ).join( withString )
	}
	
	function includes( string:String ):Boolean
	{
		return this.indexOf(string) >= 0
	}
	
	function beginsWith( string:String ):Boolean
	{
		return this.indexOf(string) == 0
	}
	
	function endsWith( string:String ):Boolean
	{
		return this.indexOf(string) == this.length - string.length
	}
	
	function capitalize():String
	{
		return this.charAt(0).toUpperCase() + this.substr(1).toLowerCase()
	}
	
	function titleize():String
	{
		var words:Array = this.split(' ')
		var length = words.length
		for( var i=0; i<length; i++ )
		{
			words[i] = words[i].charAt(0).toUpperCase() + words[i].substr(1)
		}
		return words.join(' ')
	}
	
	function get chars():Array
	{
		var a = new Array()
		for( var i=0; i<this.length; i++ )
		{
			a.push( this.charAt(i) )
		}
		return a
	}
	function get characters():Array { return this.chars	}
	
	
}