package board {
	import flash.geom.Point;
	import pieces.ChessPieceFactory;
	import pieces.IChessPiece;
	
	public class InMemoryBoardData implements BoardData {
		private var _data:Array = [];
		private var _rawData:Array;
		
		public function InMemoryBoardData(rawBoardData:Array) {
			_rawData = rawBoardData
			organizeRawChessData();
		}
		
		private function organizeRawChessData():void {
			for (var i:int = 0; i < _rawData.length; i++)
				addRowOfPieces(i);
		}
		
		private function addRowOfPieces(i:int):void {
			_data[i] = [];
			for (var j:int = 0; j < _rawData[i].length; j++)
				addPiece(i, j);
		}
		
		private function addPiece(i:int, j:int):void {
			validateTileIndexes(i, j);
			var type:Class = _rawData[i][j][0];
			var black:Boolean = _rawData[i][j][1];
			var position:Point = new Point(j, i);
			_data[i].push(ChessPieceFactory.makeChessPiece(type, position, black, this));
		}
		
		public function getChessPieceAt(x:uint, y:uint):IChessPiece {
			validateTileIndexes(y, x);
			return _data[y][x] as IChessPiece;
		}
		
		public function setChessPieceAt(x:uint, y:uint, newChessPiece:IChessPiece):void {
			validateTileIndexes(y, x);
			_data[y][x] = newChessPiece;
		}
		
		private function validateTileIndexes(y:uint, x:uint):void {
			assert(tileExistsAt(x, y), invalidInputsMessage(y, x))
		}
		
		public function tileExistsAt(x:int, y:int):Boolean {
			var xValid:Boolean = (0 <= x && x < BoardInfo.BOARD_WIDTH);
			var yValid:Boolean = (0 <= y && y < BoardInfo.BOARD_HEIGHT);
			return yValid && xValid;
		}
		
		private function invalidInputsMessage(y:uint, x:uint):String {
			return "y: " + y + ", x: " + x + " are invalid inputs, valid inputs are integers between 0 and BOARD_WIDTH - 1";
		}
	}
}