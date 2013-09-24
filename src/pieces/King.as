package pieces {
	
	/** @author Kristian Welsh */
	public class King extends ChessPiece implements IChessPiece {
		public function King(x:Number, y:Number, black:Boolean, parent:Main):void {
			super(x, y, 6, black, parent);
		}
		
		public function legalMoves():Array {
			return axisMovement(1).concat(diagonalMovement(1));
		}
	}
}