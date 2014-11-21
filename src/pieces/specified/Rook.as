package pieces.specified {
	import board.BoardData;
	import flash.geom.Point;
	import pieces.*;

	public class Rook extends ChessPiece implements IChessPiece {
		public function Rook(tileCoordinates:Point, colour:ChessPieceColour, boardData:BoardData):void {
			_type = Rook;
			_blackFrameNumber = 4;
			super(tileCoordinates, colour, boardData);
		}

		public override function legalMoves():Vector.<Point> {
			return nonDiagonalMovement(7);
		}
	}
}