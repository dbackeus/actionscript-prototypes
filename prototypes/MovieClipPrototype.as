class MovieClipPrototype
{
	static function include()
	{
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
			// override as desired
		}

		MovieClip.prototype.onFadeUpComplete = function()
		{
			// override as desired
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
	}
	
	static function remove()
	{
		MovieClip.prototype.drawRectangle = null
		MovieClip.prototype.trueWidth = null
		MovieClip.prototype.trueHeight = null
		MovieClip.prototype.buttonFix = null
		MovieClip.prototype.proportionalResize = null
		MovieClip.prototype.fadeUp = null
		MovieClip.prototype.fadeDown = null
		MovieClip.prototype.onFadeDownComplete = null
		MovieClip.prototype.onFadeUpComplete = null
		MovieClip.prototype.fade = null
		MovieClip.prototype.eachChild = null
		
	}
}