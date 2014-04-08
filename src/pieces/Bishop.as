package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class Bishop extends ChessPiece implements IChessPiece {
		public function Bishop(position:Point, black:Boolean, container:DisplayObjectContainer, boardData:BoardData):void {
			super(position, 4, black, container, boardData);
		}
		
		public function legalMoves():Array {
			return diagonalMovement(7);
		}
	}
}