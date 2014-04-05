package pieces {
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class Rook extends ChessPiece implements IChessPiece {
		public function Rook(position:Point, black:Boolean, parent:Main):void {
			super(position, 2, black, parent);
		}
		
		public function legalMoves():Array {
			return nonDiagonalMovement(7);
		}
	}
}