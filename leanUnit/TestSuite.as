/*
Example:

var suite = new TestSuite( StringTest, ArrayTest )
suite.run()

TestSuite extends Array so you can also do things like:

var suite = new TestSuite()
suite[0] = ArrayTest
suite.push( StringTest )
suite.run()

*/

import leanUnit.*

class leanUnit.TestSuite extends Array
{
	var testCount:Number = 0
	var assertionCount:Number = 0
	var failures:Array = new Array()
	var timeTaken:Number
	
	//-------------------------------------------------------------------
	//	CONSTRUCTOR
	//-------------------------------------------------------------------

	function TestSuite()
	{
		push.apply(this, arguments)
	}
	
	//-------------------------------------------------------------------
	//	PUBLIC FUNCTIONS
	//-------------------------------------------------------------------
	
	function run()
	{
		Output.writeln( "Running "+caseNames.join(', ') )
	
		reset()
		iterateAndRun()
		reportResults()
	}
	
	//-------------------------------------------------------------------
	//	PRIVATE FUNCTIONS
	//-------------------------------------------------------------------
	
	private function reset()
	{
		testCount = 0
		assertionCount = 0
		failures = new Array()
	}
	
	private function iterateAndRun()
	{
		var startTime = getTimer()
		for( var i=0; i<length; i++ )
		{
			var testCase = new this[i]()
			runCase( testCase )
		}	
		timeTaken = getTimer() - startTime
	}
	
	private function runCase( testCase:TestCase )
	{
		testCase.run()
		
		failures = failures.concat( testCase.failures )
		testCount += testCase.testMethods.length
		assertionCount += testCase.assertionCount
	}
	
	private function reportResults()
	{
		Output.writeln()
		Output.writeln('Finished in '+(timeTaken/1000)+' seconds')
		
		for( var i=0; i<failures.length; i++ )
		{
			Output.writeln()
			Output.writeln( (i+1)+")")
			Output.writeln( failures[i], "fail" )
		}
		
		Output.writeln()
		Output.writeln( testCount+" tests, "+assertionCount+" assertions, "+failures.length+" failures", failures.length > 0 ? 'fail' : 'success' )
	}
	
	function get caseNames():Array
	{
		var names = new Array()
		for( var i=0; i<length; i++ )
		{
			var instance = new this[i]()
			names.push(instance.className)
		}
		return names
	}
	
	
}