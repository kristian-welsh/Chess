package  {
	import asunit.textui.TestRunner;
	import test.AllTests;
	
	public class TestingMain extends Main {
		protected override function startGame():void {
			// Other classes rely on _chessPieces on main being set up by addPieces before receiving main as a parameter
			addPieces();
			AllTests.mainReferance = this;
			var testRunner:TestRunner = new TestRunner();
			stage.addChild(testRunner)
			testRunner.start(AllTests);
		}
	}
}