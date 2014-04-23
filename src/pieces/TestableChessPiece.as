package pieces {
	import board.BoardData;
	import flash.geom.Point;
	import test.FunctionRecord;

	public class TestableChessPiece extends ChessPiece {
		private var _functionLog:Vector.<FunctionRecord> = new Vector.<FunctionRecord>();
		
		private function logFunctionCall(functionName:String, args:Array):void {
			_functionLog.push(new FunctionRecord(functionName, args));
		}
		
		public function getFunctionCallAt(index:uint):FunctionRecord {
			return _functionLog[index];
		}
		
		public function TestableChessPiece(tileCoordinates:Point, colour:String, boardData:BoardData):void {
			_blackFrameNumber = 2;
			super(tileCoordinates, colour, boardData);
		}
		
		public override function legalMoves():Array {
			logFunctionCall("legalMoves", []);
			return [];
		}
		
		public override function gotoAndStop(frame:Object, scene:String = null):void {
			logFunctionCall("gotoAndStop", [frame, scene]);
		}
		
		public function superPathLength(limit:uint, xDirection:Number, yDirection:Number):uint {
			return super.pathLength(limit, xDirection, yDirection);
		}
	}
}