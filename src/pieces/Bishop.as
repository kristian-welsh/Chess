package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class Bishop extends ChessPiece implements IChessPiece {
		public function Bishop(tileCoordinates:Point, black:Boolean, boardData:BoardData):void {
			_type = Bishop;
			_blackFrameNumber = 8;
			super(tileCoordinates, black, boardData);
		}
		
		public override function legalMoves():Array {
			return diagonalMovement(7);
		}
	}
}