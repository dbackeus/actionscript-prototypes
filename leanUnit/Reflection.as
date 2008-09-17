/*
 * Copyright the original author or authors.
 * 
 * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.mozilla.org/MPL/MPL-1.1.html
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/**
 * {@code Reflection} obtains simple information about members.
 * 
 * <p>It is independent on any module of the As2lib. And thus does not include them
 * and does not dramatically increase the file size.
 * 
 * @author Simon Wacker
 */
class leanUnit.Reflection 
{
	
	// Returns the class name for a given object instance or class
	public static function getClassName(object):String 
	{
		if( object instanceof Function )
		{
			return getTypeNameForClass(object)
		}
		else
		{
			return getTypeNameForInstance(object)
		}
	}
	
	/**
	 * Returns the name of the class, the passed-in object is an instance of.
	 *
	 * @param instance the instance of the class to return the name of
	 * @return the name of the clas of the instance
	 */
	private static function getTypeNameForInstance(instance):String {
		_global.ASSetPropFlags(_global, null, 0, true);
		// The '__constructor__' or 'constructor' properties may not be correct with dynamic instances.
		// We thus use the '__proto__' property that referes to the prototype of the type.
		return getTypeNameByPrototype(instance.__proto__, _global, "", [_global]);
	}
	
	/**
	 * Returns the name of the passed-in class.
	 *
	 * @param class the class to return the name of
	 * @return the name of the passed-in class
	 */
	public static function getTypeNameForClass(klass:Function):String {
		_global.ASSetPropFlags(_global, null, 0, true);
		return getTypeNameByPrototype(klass.prototype, _global, "", [_global]);
	}
	
	/**
	 * Searches for the passed-in {@code c} (prototype) in the passed-in {code p}
	 * (package) and sub-packages and returns the name of the type that declares the
	 * prototype.
	 *
	 * @param c the prototype to search for
	 * @param p the package to find the type that defines the prototype in
	 * @param n the name of the preceding path separated by periods
	 * @param a already searched through packages
	 * @return the name of the type defining the prototype of {@code null}
	 */
	private static function getTypeNameByPrototype(c, p, n:String, a:Array):String 
	{
		if (n == null) n = "";
		var s:Function = _global.ASSetPropFlags;
		for (var r:String in p) {
			try {
				// flex stores every class in _global and in its actual package
				// e.g. org.as2lib.core.BasicClass is stored in _global with name org_as2lib_core_BasicClass
				// the first part of the if-clause excludes these extra stored classes
				// p[r].prototype === c because a simple == will result in wrong name when searching for the __proto__ of
				// a number
				if ((!eval("_global." + r.split("_").join(".")) || r.indexOf("_") < 0) && p[r].prototype === c) {
					var x:String = n + r;
					return x;
				}
				if (p[r].__constructor__.valueOf() == Object) {
					// prevents recursion on back-reference
					var f:Boolean = false;
					for (var i:Number = 0; i < a.length; i++) {
						if (a[i].valueOf() == p[r].valueOf()) f = true;
					}
					if (!f) {
						a.push(p[r]);
						r = getTypeNameByPrototype(c, p[r], n + r + ".", a);
						if (r) return r;
					}
				} /* No idea why this should be needed so commenting out.. else {
					if (typeof(p[r]) == "function") {
						p[r].prototype.__as2lib__typeName = n + r;
						s(p[r].prototype, "__as2lib__typeName", 1, true);
					}
				}*/
			} catch (e) {
			}
		}
		return null;
	}
	
}