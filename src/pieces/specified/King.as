package pieces.specified {
	import board.BoardData;
	import flash.geom.Point;
	import pieces.*;
	
	public class King extends ChessPiece implements IChessPiece {
		public function King(tileCoordinates:Point, colour:ChessPieceColour, boardData:BoardData):void {
			_type = King;
			_blackFrameNumber = 12
			super(tileCoordinates, colour, boardData);
		}
		
		public override function legalMoves():Array {
			return nonDiagonalMovement(1).concat(diagonalMovement(1));
		}
	}
}