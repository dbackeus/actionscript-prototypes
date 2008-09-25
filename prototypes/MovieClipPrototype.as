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

	function buttonFix()
	{
		this.onPress = function()
		{
			this._focusrect = false
			Selection.setFocus( this )
		}
	}

	function proportionalResize( w, h )
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

	function onFadeDownComplete() 
	{
		// override as desired
	}

	function onFadeUpComplete()
	{
		// override as desired
	}

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

	function eachChild()
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
	
	function get isMouseOver():Boolean
	{
		return this.hitTest(_root._xmouse, _root._ymouse, true)
	}
	
	function get centerX():Number
	{
		return (Stage.width/2)-(this._width/2)
	}
	
	function get centerY():Number
	{
		return (Stage.height/2)-(this._height/2)
	}

}