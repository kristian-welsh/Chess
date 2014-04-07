package pieces {
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class King extends ChessPiece implements IChessPiece {
		public function King(position:Point, black:Boolean, container:DisplayObjectContainer, boardData:BoardData):void {
			super(position, 6, black, container, boardData);
		}
		
		public function legalMoves():Array {
			return nonDiagonalMovement(1).concat(diagonalMovement(1));
		}
	}
}