//****************************************************************************
// ActionScript Standard Library
// String object
//****************************************************************************

intrinsic class String
{
	var length:Number;

	function String(value:String);

	static function fromCharCode():String;

	function charAt(index:Number):String;
	function charCodeAt(index:Number):Number;
	function concat(value:Object):String;
	function endswith( endString:String ):Number; // Central API
	function indexOf(value:String, startIndex:Number):Number;
	function lastIndexOf(value:String, startIndex:Number):Number;
	function slice(start:Number,end:Number):String;
	function split(delimiter:String, limit:Number):Array;
	function substr(start:Number,length:Number):String;
	function substring(start:Number,end:Number):String;
	function toLowerCase():String;
	function toString():String;
	function toUpperCase():String;
	function valueOf():String;
	
	//-------------------------------------------------------------------
	//	StringPrototype
	//-------------------------------------------------------------------
	
	function replace( string:String, withString:String ):String;
	
	function includes(s:String):Boolean;
	function beginsWith( string:String ):Boolean;
	function endsWith( string:String ):Boolean;
	
	function capitalize():String;
	function titleize():String;
	
	function toDate():Date
	
	var chars:Array
	var characters:Array
}