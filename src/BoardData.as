package  {
	import pieces.IChessPiece;
	public interface BoardData {
		function getChessPieceAt(y:uint, x:uint):IChessPiece;
	}
}