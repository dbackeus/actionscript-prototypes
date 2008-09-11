class leanUnit.Output
{
	static function write(msg, cssClass)
	{
		var classAttribute = cssClass ? ' class="'+cssClass+'"' : ''
		instance.htmlText += '<span'+classAttribute+'>'+msg+'</span>'
	}
	
	static function writeln(msg, cssClass)
	{
		write( "<p>"+(msg || '')+"</p>", cssClass )
	}
	
	static function get instance()
	{
		if( !_root.testOutputTextField )
		{
			_root.createTextField('testOutputTextField', _root.getNextHighestDepth(), 0, 0, 0, 0)
			var tf:TextField = _root.testOutputTextField
			tf._width = Stage.width
			tf._height = Stage.height
			tf.multiline = true
			tf.wordWrap = true
			tf.html = true
			tf.setNewTextFormat(textFormat)
			tf.styleSheet = styleSheet
		}
		
		return _root.testOutputTextField
	}
	
	static function get textFormat():TextFormat
	{
		var tf = new TextFormat()
		tf.font = "Monaco"
		tf.size = 10
		tf.color = 0xFFFFFF
		
		return tf
	}
	
	static function get styleSheet()
	{
		var css = new TextField.StyleSheet()
		css.parseCSS(".success { color:#00FF00; } .fail { color:#FF0000; }")
		return css
	}
}