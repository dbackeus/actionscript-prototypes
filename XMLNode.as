//****************************************************************************
// ActionScript Standard Library
// XML Document Object Model
//****************************************************************************

dynamic intrinsic class XMLNode
{
	var attributes:Object;
	var childNodes:Array;
	var firstChild:XMLNode;
	var lastChild:XMLNode;
	var nextSibling:XMLNode;
	var nodeName:String;
	var nodeType:Number;
	var nodeValue:String;
	var parentNode:XMLNode;
	var previousSibling:XMLNode;
		var localName:String; //Property containing 
       var prefix:String; // 
	 var namespaceURI:String; //

	function XMLNode(type:Number, value:String);

	function appendChild(newChild:XMLNode):Void;
	function cloneNode(deep:Boolean):XMLNode;
	function hasChildNodes():Boolean;
	function insertBefore(newChild:XMLNode,insertPoint:XMLNode):Void
	function removeNode():Void;
	function toString():String;
	function addTreeNode(arg1:Object, arg2:Object):XMLNode; //Tree mixin
	function addTreeNodeAt(index:Number, arg1:Object, arg2:Object):XMLNode; //Tree mixin;untyped args for "overloading"
	function getTreeNodeAt(index:Number):XMLNode; //Tree mixin
	function removeTreeNode():XMLNode; //Tree mixin
	function removeTreeNodeAt(index:Number):XMLNode; //Tree mixin
	function addMenuItem(arg:Object):XMLNode; //Menu mixin
	function addMenuItemAt(index:Number, arg:Object):XMLNode; //Menu mixin
	function getMenuItemAt(index:Number):XMLNode; //Menu mixin
	function indexOf(node:XMLNode):Number; //Menu mixin
	function removeMenuItem():XMLNode; //Menu mixin
	function removeMenuItemAt(index:Number):XMLNode; //Menu mixin
       function getPrefixForNamespace(nsURI:String):String //Function which 
        function getNamespaceForPrefix(prefix:String):String 
}