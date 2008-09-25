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
	Runs the passed in function on every element in the array.
	
	@param  iterator	the function to run
	@param  scope		optional parameter to specify which scope to run the iterator in
	@return nothing
	@example 
	<code> 
	var names = ['David','Erik', 'Jessica']
	
	names.each( function(name, i) { 
		trace( i+": "+name )
	})
	</code>
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
	
	/**
	Returns a new array with the results of running the passed in function on every element in the array.
	 
	@param iterator the function to run, its return value will be passed into the new array
	@return a new array
	@example
	<code>
	var persons = [
		{name:"David", age:23}
		{name:"Gabriel", age:5}
		{name:"Ganesha", age:5}
		{name:"Jimmy", age:28}
	]
	  
	var names = persons.collect( function( person ) { return person.name } )
	</code>
	*/
	
	function collect( iterator:Function ):Array
	{
		var l = this.length
		var newArray:Array = new Array()
		for( var i=0; i<l; i++ )
		{
			newArray.push( iterator.call( this, this[i] ) )
		}
		return newArray
	}
	
	/**
	Returns true if any element in the array equals the passed in object.
	 
	@param object the object to look for
	@return true or false
	@example
	<code>
	var names = ['David','Erik', 'Jessica']
	 
	names.includes( "David" ) // true
	names.includes( "Adam" ) // false
	</code>
	*/
	
	function includes( object:Object ):Boolean
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
	
	/**
	Returns a new array containing all elements in the array for which the passed in functions return value is not false.
	 
	@param selectFunction the function to determine what to look for, should return true or false
	@returns a new array
	@example
	<code>
	var persons = [
		{name:"David", age:23}
		{name:"Gabriel", age:5}
		{name:"Ganesha", age:5}
		{name:"Jimmy", age:28}
	]
	
	var adults = persons.select( function( person ) { return person.age >= 18 } )
	</code>
	*/
	
	function select( selectFunction:Function ):Array
	{
		var selected:Array = new Array()

		var l = this.length
		for( var i=0; i<l; i++ )
		{
			if( selectFunction(this[i]) ) selected.push( this[i] )
		}

		return selected.length > 0 ? selected : null
	}
	
	/**
	Returns a new array containing all elements in the array that matches the given parameter.
	
	@param propertyName the property to check on each element
	@param value the value that the given property should have
	@returns a new array
	@example
	<code>
	var persons = [
		{name:"David", age:23}
		{name:"Gabriel", age:5}
		{name:"Ganesha", age:5}
		{name:"Jimmy", age:28}
	]
	
	var fiveYearOlds = persons.selectByProperty( "age", 5 )
	</code>
	*/
	
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
	
	/**
	Passes each element in the array to the iterator and returns the first one for which the result is not false.
	
	@param detectFunction the function to determine what to look for, should return true or false
	@returns an object or null (if no element matches)
	@example
	<code>
	var persons = [
		{name:"David", age:23}
		{name:"Gabriel", age:5}
		{name:"Ganesha", age:5}
		{name:"Jimmy", age:28}
	]
	
	var firstAdult = persons.detect( function( person ) { return person.age >= 18 } )
	</code>
	*/
	
	function detect( detectFunction:Function ):Object
	{
		var l = this.length
		for( var i=0; i<l; i++ )
		{
			if( detectFunction(this[i]) ) return this[i]
		}
		return null
	}
	
	/**
	Returns the first element in the array matching the given parameters.
	
	@param propertyName the property to check on each element
	@param value the value that the given property should have
	@returns an object or null (if no element matches)
	@example
	<code>
	var persons = [
		{name:"David", age:23}
		{name:"Gabriel", age:5}
		{name:"Ganesha", age:5}
		{name:"Jimmy", age:28}
	]
	
	var firstFiveYearOld = persons.detect( "age", 5 )
	</code>
	*/
	function detectByProperty( propertyName:String, value ):Object
	{
		var l = this.length
		for( var i=0; i<l; i++ )
		{
			if( this[i][propertyName] == value ) return this[i]
		}
	}
	
	/**
	Returns a new array containing all elements in the array for which the passed in functions return value is false.
	
	@param rejectFunction the function to determine what to keep out, should return true or false
	@returns a new array
	@example
	<code>
	var persons = [
		{name:"David", age:23}
		{name:"Gabriel", age:5}
		{name:"Ganesha", age:5}
		{name:"Jimmy", age:28}
	]
	
	var adults = persons.reject( function( person ) { return person.age < 18 } )
	</code>
	*/
	
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
	
	/**
	Returns a new array containing all elements in the array that does not match the given parameter.
	
	@param propertyName the property to check on each element
	@param value the value that the given property should (not) have
	@returns a new array
	@example
	<code>
	var persons = [
		{name:"David", age:23}
		{name:"Gabriel", age:5}
		{name:"Ganesha", age:5}
		{name:"Jimmy", age:28}
	]
	
	var everyoneButTheFiveYearOlds = persons.rejectByProperty( "age", 5 )
	</code>
	*/
	
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
	
	/**
	Randomizes the order of the elements in the array.
	*/
	
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
	
	/**
	Removes (splices) the given object from the array and returns it.
	
	@param object the object to look for
	@returns the object (if found) or null (if not found)
	@example
	<code>
	var names = ['David','Erik', 'Jessica']
	
	names.remove("Erik")
	trace( names ) // ["David", "Jessica"]
	</code>
	*/
	
	function remove( object:Object ):Object
	{
		var l:Number = this.length
		while(l--) 
		{
			if(this[l] == object) 
			{
				var value = this[l]
				this.splice(l, 1)
				return value
			}
		}
		return null
	}
	
	/**
	Returns the sum of all elements of the array added together. Only makes sense if the array consists only of numbers.
	@returns a number
	@example
	<code>
	var numbers = [30, 10, 20]
	
	trace( numbers.sum() ) // 60
	</code>
	*/
	
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