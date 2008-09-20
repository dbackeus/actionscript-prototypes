//****************************************************************************
// ActionScript Standard Library
// Object object
//****************************************************************************

intrinsic class Object
{
	static var prototype:Object;

	var __proto__:Object;
	var __resolve:Object;	
	var constructor:Object;

	function Object();

	static function registerClass(name:String, theClass:Function):Boolean;

	function addProperty(name:String, getter:Function, setter:Function):Boolean;
	function hasOwnProperty(name:String):Boolean;
	function isPropertyEnumerable(name:String):Boolean;
	function isPrototypeOf(theClass:Object):Boolean;
	function toLocaleString():String;
	function toString():String;
	function unwatch(name:String):Boolean;
	function valueOf():Object;
	function watch(name:String, callback:Function, userData:Object):Boolean;
	
	//-------------------------------------------------------------------
	//	ObjectPrototype
	//-------------------------------------------------------------------
	
	function inspect():String
	function toNumber():Number
	function toInt():Number
}