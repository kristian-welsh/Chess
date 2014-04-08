package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class Rook extends ChessPiece implements IChessPiece {
		public function Rook(position:Point, black:Boolean, container:DisplayObjectContainer, boardData:BoardData):void {
			super(position, 2, black, container, boardData);
		}
		
		public function legalMoves():Array {
			return nonDiagonalMovement(7);
		}
	}
}