package board {
	import flash.geom.Point;
	import pieces.*;
	
	public class InMemoryBoardData implements BoardData {
		private var _data:Array = [];
		private var _rawData:Array;
		
		public function organizeRawChessData(rawBoardData:Array):void {
			_rawData = rawBoardData
			for (var i:int = 0; i < _rawData.length; i++)
				addRowOfPieces(i);
		}
		
		private function addRowOfPieces(i:int):void {
			_data[i] = [];
			for (var j:int = 0; j < _rawData[i].length; j++)
				addPiece(i, j);
		}
		
		private function addPiece(i:int, j:int):void {
			validateTileIndexes(j, i);
			var type:Class = _rawData[i][j][0];
			var colour:ChessPieceColour = _rawData[i][j][1];
			var position:Point = new Point(j, i);
			_data[i].push(ChessPieceFactory.makeChessPiece(type, position, colour, this));
		}
		
		public function getChessPieceAt(x:uint, y:uint):IChessPiece {
			validateTileIndexes(x, y);
			return _data[y][x] as IChessPiece;
		}
		
		public function addPieceToBoard(newChessPiece:IChessPiece):void {
			validateTileIndexes(newChessPiece.tileX, newChessPiece.tileY);
			_data[newChessPiece.tileY][newChessPiece.tileX] = newChessPiece;
		}
		
		private function validateTileIndexes(x:uint, y:uint):void {
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