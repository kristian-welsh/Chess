package pieces.specified {
	import board.BoardData;
	import flash.geom.Point;
	import pieces.*;

	public class Bishop extends ChessPiece implements IChessPiece {
		public function Bishop(tileCoordinates:Point, colour:ChessPieceColour, boardData:BoardData):void {
			_type = Bishop;
			_blackFrameNumber = 8;
			super(tileCoordinates, colour, boardData);
		}

		public override function legalMoves():Vector.<Point> {
			return diagonalMovement(9);
		}
	}
}