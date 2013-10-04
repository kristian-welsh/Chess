package pieces {
	
	/** @author Kristian Welsh */
	public class Queen extends ChessPiece implements IChessPiece {
		public function Queen(x:Number, y:Number, black:Boolean, parent:Main):void {
			super(x, y, 5, black, parent);
		}
		
		public function legalMoves():Array {
			return nonDiagonalMovement(7).concat(diagonalMovement(7));
		}
	}
}