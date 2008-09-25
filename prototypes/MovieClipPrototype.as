import prototypes.*

dynamic class prototypes.MovieClipPrototype
{
	//-------------------------------------------------------------------
	//	CLASS METHOD API
	//-------------------------------------------------------------------
	
	static function include( propertyName:String )
	{
		var instance = new MovieClipPrototype()
		if( !instance[propertyName])
		{
			trace( "MovieClipPrototype does not contain the "+propertyName+" property" )
		}
		else
		{
			MovieClip.prototype[propertyName] = instance[propertyName]
		}
	}
	
	static function includeAll()
	{
		Prototype.includeClass( MovieClipPrototype, MovieClip )
	}
	
	static function revertAll()
	{
		Prototype.revertClass( MovieClipPrototype, MovieClip )
	}
	
	//-------------------------------------------------------------------
	//	PROTOTYPE METHODS
	//-------------------------------------------------------------------
	
	/**
	Draws a rectangle inside the movieclip based on the given parameters.
	
	@param width the width of the rectangle
	@param height the height of the rectangle
	@param color the color to use for fill (black by default)
	@param alpha the alpha of the fill (100 by default)
	@returns nothing
	*/
	
	function drawRectangle( width:Number, height:Number, color:Number, alpha:Number )
	{
		color = color || 0x000000
		alpha = alpha || 100

		this.beginFill( color, alpha )
		this.lineTo( width, 0 )
		this.lineTo( width, height )
		this.lineTo( 0, height )
		this.endFill()
	}

	/**
	This function resolves a bug involving V2 Components like the combobox messing up MovieClip mouse events. 
	For more information see {@link http://www.webomatica.com/wordpress/2008/03/06/flash-tip-combobox-component-breaks-buttons}
	
	@returns nothing
	*/

	function buttonFix()
	{
		this.onPress = function()
		{
			this._focusrect = false
			Selection.setFocus( this )
		}
	}
	
	/**
	Resizes the movieclip while keeping the aspect ratio.
	
	@param width the maximum width to resize to
	@param height the maximum height to resize to
	@returns nothing
	*/
	
	function proportionalResize( width:Number, height:Number )
	{
		var oldXScale = this._xscale
		var oldYScale = this._yscale

		this._xscale = this._yscale = 100

		if( width > height )
		{
			var percent = width / this._width
			this._width = width
			this._height *= percent
		}
		else
		{
			var percent = height / this._height
			this._height = height
			this._width *= percent
		}
	}

	/**
	Fades the _alpha property up to 100 and runs onFadeUpComplete() when done.
	
	@param speed the amount to increase the alpha on every interval
	@returns nothing
	*/
	
	function fadeUp( speed:Number )
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

	/**
	Fades the _alpha property down to 0 and runs onFadeDownComplete() when done.
	
	@param speed the amount to decrease the alpha on every interval
	@returns nothing
	*/

	function fadeDown( speed:Number )
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

	/**
	Runs after fadeUp() completes.
	*/

	function onFadeDownComplete() 
	{
		// override as desired
	}
	
	/**
	Runs after fadeDown() completes.
	*/

	function onFadeUpComplete()
	{
		// override as desired
	}
	
	/**
	Used internally through an interval by fadeUp and fadeDown
	
	@private
	*/
	
	function fade( to:Number, difference:Number )
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
	
	/**
	Runs the given iterator on every MovieClip and TextField inside the clip.
	
	@param iterator the function to run
	@param scope the scope to run the iterator in
	@returns nothing
	@example
	<code>
	myClip.eachChild( function( child ) { child._visible = false } ) // Hides all clips inside myClip
	</code>
	*/
	
	function eachChild( iterator:Function, scope:Object )
	{
		scope = scope || this

		for( var p in this )
		{
			if( this[p] instanceof MovieClip || this[p] instanceof TextField) iterator.call( scope, this[p], p )
		}
	}
	
	/**
	Returns the original width of the movieclip (seeing through scaling etc).
	
	@returns a number
	*/
	
	function get trueWidth():Number
	{
		var currentXScale = this._xscale
		var currentYScale = this._yscale

		this._xscale = this._yscale = 100

		var truth = this._width

		this._xscale = currentXScale
		this._yscale = currentYScale
		
		return truth
	}
	
	/**
	Returns the original height of the movieclip (seeing through scaling etc).
	
	@returns a number
	*/
	
	function get trueHeight():Number
	{ 
		var currentXScale = this._xscale
		var currentYScale = this._yscale

		this._xscale = this._yscale = 100

		var truth = this._height

		this._xscale = currentXScale
		this._yscale = currentYScale

		return truth
	}
	
	/**
	Returns true if the mouse is hovering the movieclip. Useful for custom mouse events when you just cant use the regular ones.
	
	@returns true or false
	*/
	
	function get isMouseOver():Boolean
	{
		return this.hitTest(_root._xmouse, _root._ymouse, true)
	}
	
	/**
	Returns the _x coordinate that should put the moviclip in the center relative to Stage.
	
	@returns an integer
	*/
	
	function get centerX():Number
	{
		return int((Stage.width/2)-(this._width/2))
	}
	
	/**
	Returns the _y coordinate that should put the moviclip in the center relative to Stage.
	
	@returns an integer
	*/
	
	function get centerY():Number
	{
		return int((Stage.height/2)-(this._height/2))
	}

}