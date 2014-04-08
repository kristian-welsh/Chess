package {
	import asunit.textui.TestRunner;
	import flash.events.Event;
	import test.AllTests;
	
	public class TestingMain extends Main {
		private var testRunner:TestRunner = new TestRunner();
		
		protected override function startGame(e:Event = null):void {
			displayResultsPane();
			runTests();
		}
		
		private function displayResultsPane():void {
			stage.addChild(testRunner)
		}
		
		private function runTests():void {
			testRunner.start(AllTests);
		}
	}
}