package pieces {
	import board.BoardData;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class Bishop extends ChessPiece implements IChessPiece {
		public function Bishop(tileCoordinates:Point, colour:ChessPieceColour, boardData:BoardData):void {
			_type = Bishop;
			_blackFrameNumber = 8;
			super(tileCoordinates, colour, boardData);
		}
		
		public override function legalMoves():Array {
			return diagonalMovement(7);
		}
	}
}