package pieces {
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class Bishop extends ChessPiece implements IChessPiece {
		public function Bishop(position:Point, black:Boolean, parent:Main):void {
			super(position, 4, black, parent);
		}
		
		public function legalMoves():Array {
			return diagonalMovement(7);
		}
	}
}