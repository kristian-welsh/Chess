package pieces {
	
	/** @author Kristian Welsh */
	public class Rook extends ChessPiece implements IChessPiece {
		public function Rook(x:Number, y:Number, black:Boolean, parent:Main):void {
			super(x, y, 2, black, parent);
		}
		
		public function legalMoves():Array {
			return nonDiagonalMovement(7);
		}
	}
}