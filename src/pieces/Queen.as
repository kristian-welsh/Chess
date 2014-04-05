package pieces {
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class Queen extends ChessPiece implements IChessPiece {
		public function Queen(position:Point, black:Boolean, parent:Main):void {
			super(position, 5, black, parent);
		}
		
		public function legalMoves():Array {
			return nonDiagonalMovement(7).concat(diagonalMovement(7));
		}
	}
}