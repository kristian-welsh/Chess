package  {
	import asunit.textui.TestRunner;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import rawdata.RawTestData;
	import test.AllTests;
	
	public class TestingMain extends Main {
		protected override function startGame(e:Event = null):void {
			initTestingData();
			loadBoardData();
			runTests();
		}
		
		private function initTestingData():void {
			_rawBoardData = RawTestData.data
		}
		
		public function resetChessPieces():void {
			for each(var row:Array in _boardData.chessPieces)
				for each (var piece:DisplayObject in row)
					removeChild(piece);
			super.loadBoardData()
		}
		
		private function runTests():void {
			AllTests.mainReferance = this;
			var testRunner:TestRunner = new TestRunner();
			stage.addChild(testRunner)
			testRunner.start(AllTests);
		}
	}
}