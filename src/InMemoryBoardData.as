package  {
	import pieces.IChessPiece;
	import pieces.NullChessPiece;

	public class InMemoryBoardData implements BoardData {
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
	}
}