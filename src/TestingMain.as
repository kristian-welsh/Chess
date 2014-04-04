package  {
	import asunit.textui.TestRunner;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import pieces.IChessPiece;
	import test.AllTests;
	
	public class TestingMain extends Main {
		protected override function startGame(e:Event = null):void {
			initTestingData();
			organizeChessData();
			runTests();
		}
		
		private function initTestingData():void {
			_rawBoardData = [
			[p07, p00, p00, p00, p00, p00, p00, p00],
			[p00, p00, p00, p00, p00, p00, p00, p00],
			[p00, p00, p00, p00, p00, p00, p00, p00],
			[p00, p00, p00, p00, p00, p00, p00, p00],
			[p00, p00, p00, p00, p00, p00, p00, p00],
			[p00, p00, p00, p00, p00, p00, p00, p00],
			[p01, p01, p00, p00, p00, p00, p00, p00],
			[p00, p00, p00, p00, p00, p00, p00, p00]];
		}
		
		public function resetChessPieces():void {
			for each(var row:Array in chessPieces)
				for each (var piece:DisplayObject in row)
					removeChild(piece);
			super.organizeChessData()
		}
		
		private function runTests():void {
			AllTests.mainReferance = this;
			var testRunner:TestRunner = new TestRunner();
			stage.addChild(testRunner)
			testRunner.start(AllTests);
		}
		
		public function get rawData():Array {
			return _rawBoardData;
		}
	}
}