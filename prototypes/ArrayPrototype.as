import prototypes.*

dynamic class prototypes.ArrayPrototype extends Array
{	
	//-------------------------------------------------------------------
	//	CLASS METHOD API
	//-------------------------------------------------------------------
	
	static function include( propertyName:String )
	{
		var instance = new ArrayPrototype()
		if( !instance[propertyName])
		{
			trace( "ArrayPrototype does not contain the "+propertyName+" property" )
		}
		else
		{
			Array.prototype[propertyName] = instance[propertyName]
		}
	}
	
	static function includeAll()
	{
		Prototype.includeClass( ArrayPrototype, Array )
	}
	
	static function revertAll()
	{
		Prototype.revertClass( ArrayPrototype, Array )
	}
	
	//-------------------------------------------------------------------
	//	PROTOTYPE METHODS
	//-------------------------------------------------------------------
	
	/**
	 * Runs the passed in function on every element in the array.
	 *
	 * @param  iterator	the function to run
	 * @param  scope		optional parameter to specify which scope to run the iterator in
	 * @return      nothing
	 * @example 
	 * <pre> 
	 * var names = ['David','Erik', 'Jessica']
	 *
	 * a.each( function(element, i) { 
	 *		trace( i+": "+element )
	 * })
	 * </pre>
	 */
	
	function each( iterator:Function, scope:Object )
	{
			scope = scope || this

		  var len = this.length;
			for( var i=0; i<len; i++ )
			{
				iterator.call( thisObject, this[i], i )
			}
	}
	
	function collect( block:Function ):Array
	{
		var l = this.length
		var newArray:Array = new Array()
		for( var i=0; i<l; i++ )
		{
			newArray.push( block.call( this, this[i] ) )
		}
		return newArray
	}
	
	function includes( o:Object ):Boolean
	{
		var l = this.length
		for( var i=0; i<l; i++ )
		{
			if( this[i] == o )
			{
				return true
			}
		}
		return false
	}
	
	function select( block:Function ):Array
	{
		var selected:Array = new Array()

		var l = this.length
		for( var i=0; i<l; i++ )
		{
			if( block(this[i]) ) selected.push( this[i] )
		}

		return selected.length > 0 ? selected : null
	}
	
	function selectByProperty( propertyName:String, value ):Array
	{
		var selected:Array = new Array()
		var l = this.length
		for( var i=0; i<l; i++ )
		{
			if( this[i][propertyName] == value ) selected.push( this[i] )
		}
		return selected
	}
	
	function detect( block:Function ):Object
	{
		var l = this.length
		for( var i=0; i<l; i++ )
		{
			if( block(this[i]) ) return this[i]
		}
		return null
	}
	
	function detectByProperty( propertyName:String, value ):Object
	{
		var l = this.length
		for( var i=0; i<l; i++ )
		{
			if( this[i][propertyName] == value ) return this[i]
		}
	}
	
	function reject( rejectFunction:Function ):Array
	{
		var notRejected:Array = new Array()
		var l = this.length
		for( var i=0; i<l; i++ )
		{
			if( !rejectFunction( this[i] ) ) notRejected.push( this[i] )
		}
		return notRejected
	}
	
	function rejectByProperty( propertyName:String, value ):Array
	{
		var notRejected:Array = new Array()
		var l = this.length
		for( var i=0; i<l; i++ )
		{
			if( this[i][propertyName] != value ) notRejected.push( this[i] )
		}
		return notRejected
	}
	
	function randomize():Array
	{
		var i = this.length
		if (i == 0) return []
		while (--i) 
		{
			var j = Math.floor(Math.random()*(i+1))
			var tmp1 = this[i]
			var tmp2 = this[j]
			this[i] = tmp2
			this[j] = tmp1
		}
		return this
	}
	
	function remove( o:Object ):Object
	{
		var l:Number = this.length
		while(l--) 
		{
			if(this[l] == o) 
			{
				var value = this[l]
				this.splice(l, 1)
				return value
			}
		}
		return null
	}
	
	function sum():Number
	{
		var result:Number = 0
		
		var l:Number = this.length
		for( var i=0; i<l; i++ )
		{
			result += Number(this[i])
		}
		
		return result
	}
}