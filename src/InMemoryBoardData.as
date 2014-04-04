package  {
	import pieces.IChessPiece;
	import pieces.NullChessPiece;

	public class InMemoryBoardData implements BoardData {
		static public const BOARD_WIDTH:uint = 8;
		static public const BOARD_HEIGHT:uint = 8;
		static public const TILE_WIDTH:Number = 36;
		static public const BORDER_WIDTH:Number = 12;
		
		private var _data:Array;
		
		public function InMemoryBoardData(data:Array) {
			_data = data;
		}
		
		public function getChessPieceAt(y:uint, x:uint):IChessPiece {
			return _data[y][x] as IChessPiece;
		}
		
		public function setChessPieceAt(y:uint, x:uint, newChessPiece:IChessPiece):void {
			_data[y][x] = newChessPiece;
		}
		
		private function validateTileIndexes(y:uint, x:uint):void {
			assert(y < BOARD_HEIGHT && x < BOARD_WIDTH, invalidInputsMessage(y, x))
		}
		
		private function invalidInputsMessage(y:uint, x:uint):String {
			return "y: " + y + ", x: " + x + " are invalid inputs, valid inputs are integers between 0 and BOARD_WIDTH - 1";
		}
		
		public function get data():Array {
			return _data;
		}
	}
}