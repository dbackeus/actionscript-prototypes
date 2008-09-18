/*

History:
17-6 2008 - Added Array.select
17-6 2008 - Added Array.detect
17-6 2008 - Added Array.include and includes
6-5 2008 - Added Array.collect
6-5 2008 - Added MovieClip.drawRectangle()

*/

//-------------------------------------------------------------------
//	OBJECT
//-------------------------------------------------------------------

Object.prototype.toNumber = function():Number
{
	return Number( this )
}

Object.prototype.toInt = function():Number
{
	return int( this )
}

Object.prototype.eachProperty = function()
{
	var thisObject = this
	var iterator = arguments[0]
	if( arguments.length > 1 )
	{
		thisObject = arguments[0]
		iterator = arguments[1]
	}
	
	for( var p in this )
	{
		iterator.call( thisObject, this[p], p )
	}
}

Object.prototype.inspect = function():String
{
	var s = this.toString()+" {\n"
	for( var p in this )
	{
		s += "\t"+p+": "+this[p]+"\n"
	}
	s += "}"
	return s
}

// TODO: publicMethods

//-------------------------------------------------------------------
//	XML
//-------------------------------------------------------------------

XMLNode.prototype.__resolve = function( name:String ):XMLNode
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

XMLNode.prototype.toObject = function():Object
{
	return utils.XMLParser.toObject( this )
}

//-------------------------------------------------------------------
//	NUMBER
//-------------------------------------------------------------------

/*
* Rails like number to date properties. Scenario:
*
* n = 23
* trace( n.days.ago )
*/

Number.prototype.addProperty( "seconds", function() { return this*1000 }, null )
Number.prototype.addProperty( "second", function() { return this.seconds }, null )

Number.prototype.addProperty( "minutes", function() { return this*1000*60 }, null )
Number.prototype.addProperty( "minute", function() { return this.minutes }, null )

Number.prototype.addProperty( "hours", function() { return this*1000*60*60 }, null )
Number.prototype.addProperty( "hours", function() { return this.hours }, null )

Number.prototype.addProperty( "days", function() { return this.hours*24 }, null )
Number.prototype.addProperty( "day", function() { return this.days }, null )

Number.prototype.addProperty( "weeks", function() { return this.days*7 }, null )
Number.prototype.addProperty( "week", function() { return this.weeks }, null )

Number.prototype.addProperty( "ago", function() { return new Date( new Date().valueOf() - this ) }, null )
Number.prototype.addProperty( "fromNow", function() { return new Date( new Date().valueOf() + this ) }, null )

Number.prototype.addProperty( "isEven", function() { return (this % 2 == 0)  }, null )
Number.prototype.addProperty( "isOdd", function() { return (this % 2 != 0)  }, null )

Number.prototype.round = function():Number
{
	return Math.round( this )
}

Number.prototype.zerofy = function():String
{
	return this > 9 ? this.toString() : "0"+this
}

//-------------------------------------------------------------------
//	STRING
//-------------------------------------------------------------------

String.prototype.replace = function( replaceWord, withWord ):String
{
	return this.split( replaceWord ).join( withWord )
}

//-------------------------------------------------------------------
//	MovieClip
//-------------------------------------------------------------------

MovieClip.prototype.addProperty( "isMouseOver", function() { return this.hitTest(_root._xmouse, _root._ymouse, true) }, null )

MovieClip.prototype.drawRectangle = function( w:Number, h:Number, color:Number, alpha:Number )
{
	color = color || 0x000000
	alpha = alpha || 100
	
	this.beginFill( color, alpha )
	this.lineTo( w, 0 )
	this.lineTo( w, h )
	this.lineTo( 0, h )
	this.endFill()
}

MovieClip.prototype.trueWidth = function():Number
{
	var currentXScale = this._xscale
	var currentYScale = this._yscale
	
	this._xscale = this._yscale = 100
	
	var truth = this._width
	
	this._xscale = currentXScale
	this._yscale = currentYScale
	
	return truth
}

MovieClip.prototype.trueHeight = function():Number
{
	var currentXScale = this._xscale
	var currentYScale = this._yscale
	
	this._xscale = this._yscale = 100
	
	var truth = this._height
	
	this._xscale = currentXScale
	this._yscale = currentYScale
	
	return truth
}

MovieClip.prototype.buttonFix = function()
{
	this.onPress = function()
	{
		this._focusrect = false
		Selection.setFocus( this )
	}
}

MovieClip.prototype.proportionalResize = function( w, h )
{
	var oldXScale = this._xscale
	var oldYScale = this._yscale
	
	this._xscale = this._yscale = 100
	
	if( w > h )
	{
		var percent = w / this._width
		this._width = w
		this._height *= percent
	}
	else
	{
		var percent = h / this._height
		this._height = h
		this._width *= percent
	}
}

MovieClip.prototype.fadeUp = function( speed:Number ):Void
{
	if( this._alpha == 100 )
	{
		this.onFadeUpComplete()
		return
	}
	speed = speed || 5;
	clearInterval( this.fadeId );
	this.fadeId = setInterval( this, "fade", 30, 100, speed );
}

MovieClip.prototype.fadeDown = function( speed:Number ):Void
{
	if( this._alpha == 0 )
	{
		this.onFadeDownComplete()
		return
	}
	speed = speed || 5;
	clearInterval( this.fadeId );
	this.fadeId = setInterval( this, "fade", 30, 0, speed );
}

MovieClip.prototype.onFadeDownComplete = function()
{
	//trace( "OVERRIDE?!??" );
}

MovieClip.prototype.onFadeUpComplete = function()
{
	//trace( "OVERRIDE?!??" );
}

MovieClip.prototype.fade = function( to:Number, difference:Number ):Void
{
	if( this._alpha < to )
	{
		this._alpha += difference;
		if( this._alpha >= to )
		{
			this._alpha = to;
			clearInterval( this.fadeId );
			this.onFadeUpComplete();
		}
	}
	else
	{
		this._alpha -= difference;
		if( this._alpha <= to )
		{
			this._alpha = to;
			clearInterval( this.fadeId );
			this.onFadeDownComplete();
		}
	}
}

MovieClip.prototype.eachChild = function()
{
	var thisObject = this
	var iterator = arguments[0]
	if( arguments.length > 1 )
	{
		thisObject = arguments[0]
		iterator = arguments[1]
	}
	
	for( var p in this )
	{
		if( this[p] instanceof MovieClip || this[p] instanceof TextField) iterator.call( thisObject, this[p], p )
	}
}

MovieClip.prototype.addProperty( "centerX", function() { return (Stage.width/2)-(this._width/2) }, null )
MovieClip.prototype.addProperty( "centerY", function() { return (Stage.height/2)-(this._height/2) }, null )

//-------------------------------------------------------------------
//	Array
//-------------------------------------------------------------------

Array.prototype.merge = function( a2:Array ):Array
{
	var separator = "%|DELIMITER|%"
	var s1 = this.join( separator )
	var s2 = a2.join( separator )
	var merged = s1+separator+s2
	
	return merged.split( separator )
}

// Usage: 
// 1: array.each( function( item ) { trace( item ) }
// 2: array.each( this, function( item ) { trace( this+": "+item ) }
Array.prototype.each = function() 
{
	var thisObject = this
	var iterator = arguments[0]
	if( arguments.length > 1 )
	{
		thisObject = arguments[0]
		iterator = arguments[1]
	}
	
    var len = this.length;
	
	for( var i=0; i<len; i++ )
	{
		iterator.call( thisObject, this[i] )
	}
}

Array.prototype.eachWithIndex = function() 
{
	var thisObject = this
	var iterator = arguments[0]
	if( arguments.length > 1 )
	{
		thisObject = arguments[0]
		iterator = arguments[1]
	}
	
    var len = this.length;
	
	for( var i=0; i<len; i++ )
	{
		iterator.call( thisObject, this[i], i )
	}
}

/*
=== Collect

var a = [
{name:"David", age:23},
{name:"Ola", age:5},
{name:"Jimmy", age:28}
]

a.collect( function( element ) {
	return element.name
})

=> ["David", "Ola", "Jimmy"]

*/
Array.prototype.collect = function( block:Function ):Array
{
	var l = this.length
	var newArray:Array = new Array()
	for( var i=0; i<l; i++ )
	{
		newArray.push( block.call( this, this[i] ) )
	}
	return newArray
}

Array.prototype.include = function( o:Object ):Boolean
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
Array.prototype.includes = function( o:Object ):Boolean
{
	return this.include( o )
}

Array.prototype.select = function( block:Function ):Array
{
	var selected:Array = new Array()
	
	var l = this.length
	for( var i=0; i<l; i++ )
	{
		if( block(this[i]) ) selected.push( this[i] )
	}
	
	return selected.length > 0 ? selected : null
}

Array.prototype.detect = function( block:Function ):Object
{
	var l = this.length
	for( var i=0; i<l; i++ )
	{
		if( block(this[i]) ) return this[i]
	}
	return null
}

Array.prototype.findByProperty = function( propertyName:String, value ):Object
{
	var l = this.length
	for( var i=0; i<l; i++ )
	{
		if( this[i][propertyName] == value ) return this[i]
	}
}

Array.prototype.find = function( searchFunction:Function ):Object
{
	var l = this.length
	for( var i=0; i<l; i++ )
	{
		if( searchFunction( this[i] ) ) return this[i]
	}
}

Array.prototype.findAll = function( searchFunction:Function ):Array
{
	var findings:Array = new Array()
	var l = this.length
	for( var i=0; i<l; i++ )
	{
		if( searchFunction( this[i] ) ) findings.push( this[i] )
	}
	return findings
}

Array.prototype.findAllByProperty = function( propertyName:String, value ):Array
{
	var findings:Array = new Array()
	var l = this.length
	for( var i=0; i<l; i++ )
	{
		if( this[i][propertyName] == value ) findings.push( this[i] )
	}
	return findings
}

Array.prototype.reject = function( rejectFunction:Function ):Array
{
	var notRejected:Array = new Array()
	var l = this.length
	for( var i=0; i<l; i++ )
	{
		if( !rejectFunction( this[i] ) ) notRejected.push( this[i] )
	}
	return notRejected
}

Array.prototype.rejectByProperty = function( propertyName:String, value ):Array
{
	var notRejected:Array = new Array()
	var l = this.length
	for( var i=0; i<l; i++ )
	{
		if( this[i][propertyName] != value ) notRejected.push( this[i] )
	}
	return notRejected
}

//Array.prototype.addProperty( "first", function() { return this[0] }, null )
//Array.prototype.addProperty( "last", function() { return this[this.length-1] }, null )

Array.prototype.randomize = function() 
{
	var i = this.length;
	if (i == 0) return;
	while (--i) 
	{
		var j = Math.floor(Math.random()*(i+1));
		var tmp1 = this[i];
		var tmp2 = this[j];
		this[i] = tmp2;
		this[j] = tmp1;
	}
	return this;
}

Array.prototype.remove = function( o:Object ):Object 
{
	var l:Number = this.length;
	while(l--) 
	{
		if(this[l] == o) 
		{
			var value = this[l]
			this.splice(l, 1);
			return value;
		}
	}
	return null;
}