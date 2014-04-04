package  {
	import pieces.ChessPieceFactory;
	import pieces.IChessPiece;
	import pieces.NullChessPiece;

	public class InMemoryBoardData implements BoardData {
		static public const BOARD_WIDTH:uint = 8;
		static public const BOARD_HEIGHT:uint = 8;
		static public const TILE_WIDTH:Number = 36;
		static public const BORDER_WIDTH:Number = 12;
		
		private var _data:Array = [];
		private var _rawData:Array;
		
		public function InMemoryBoardData(rawBoardData:Array) {
			_rawData = rawBoardData
		}
		
		public function organizeRawChessData():void {
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
			var type:uint = _rawData[i][j][0];
			var black:Boolean = _rawData[i][j][1];
			var x:Number = tilePos(j);
			var y:Number = tilePos(i);
			_data[i].push(ChessPieceFactory.makeChessPiece(type, x, y, black));
		}
		
		private function tilePos(tileIndex:int):Number {
			return tileIndex * TILE_WIDTH + BORDER_WIDTH;
		}
		
		private function validateTileIndexes(y:uint, x:uint):void {
			assert(y < BOARD_HEIGHT && x < BOARD_WIDTH, invalidInputsMessage(y, x))
		}
		
		private function invalidInputsMessage(y:uint, x:uint):String {
			return "y: " + y + ", x: " + x + " are invalid inputs, valid inputs are integers between 0 and BOARD_WIDTH - 1";
		}
		
		public function get chessPieces():Array {
			return _data;
		}
		
		public function getChessPieceAt(y:uint, x:uint):IChessPiece {
			return _data[y][x] as IChessPiece;
		}
		
		public function setChessPieceAt(y:uint, x:uint, newChessPiece:IChessPiece):void {
			_data[y][x] = newChessPiece;
		}
	}
}