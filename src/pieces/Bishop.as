package pieces {
	
	/** @author Kristian Welsh */
	public class Bishop extends ChessPiece implements IChessPiece {
		public function Bishop(x:Number, y:Number, black:Boolean, parent:Main):void {
			super(x, y, 4, black, parent);
		}
		
		public function legalMoves():Array {
			return diagonalMovement(7);
		}
	}
}