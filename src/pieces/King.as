package pieces {
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class King extends ChessPiece implements IChessPiece {
		public function King(position:Point, black:Boolean, parent:Main):void {
			super(position, 6, black, parent);
		}
		
		public function legalMoves():Array {
			return nonDiagonalMovement(1).concat(diagonalMovement(1));
		}
	}
}