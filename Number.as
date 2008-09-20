//****************************************************************************
// ActionScript Standard Library
// Number object
//****************************************************************************

intrinsic class Number
{
	static var MAX_VALUE:Number;
	static var MIN_VALUE:Number;
	static var NaN:Number;
	static var NEGATIVE_INFINITY:Number;
	static var POSITIVE_INFINITY:Number;

	function Number(num:Object);
	
	function toString(radix:Number):String;	
	function valueOf():Number;
	
	//-------------------------------------------------------------------
	//	NumberPrototype
	//-------------------------------------------------------------------
	
	// So the getters had to be described as variables to make sure the flash
	// compiler didn't malfunction on things like (34).days
	
	var seconds:Number
	var second:Number
	var minutes:Number
	var minute:Number
	var hours:Number
	var hour:Number
	var days:Number
	var day:Number
	var weeks:Number
	var week:Number
	
	var ago:Date
	var fromNow:Date
	
	var isOdd:Boolean
	var isEven:Boolean
	
	var chars:Array
	var characters:Array
	
	function round():Number
	function floor():Number
	function ceil():Number
}