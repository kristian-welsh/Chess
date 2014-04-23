package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class Queen extends ChessPiece implements IChessPiece {
		public function Queen(tileCoordinates:Point, colour:ChessPieceColour, boardData:BoardData):void {
			_type = Queen;
			_blackFrameNumber = 10;
			super(tileCoordinates, colour, boardData);
		}
		
		public override function legalMoves():Array {
			return nonDiagonalMovement(7).concat(diagonalMovement(7));
		}
	}
}