package board {
	import pieces.IChessPiece;
	public interface BoardData {
		function getChessPieceAt(x:uint, y:uint):IChessPiece;
		function addPieceToBoard(newChessPiece:IChessPiece):void;
		function tileExistsAt(x:int, y:int):Boolean;
	}
}