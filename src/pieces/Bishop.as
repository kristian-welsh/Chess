package pieces {
	
	/** @author Kristian Welsh */
	public class Bishop extends ChessPiece implements IChessPiece {
		public function Bishop(x:Number, y:Number, black:Boolean, parent:Main):void {
			super(x, y, 4, black, parent);
		}
		
		public function legalMoves():Array {
			_upLeftTiles = upLeft(7);
			_upRightTiles = upRight(7);
			_downLeftTiles = downLeft(7);
			_downRightTiles = downRight(7);
			return loopDIAGS(7);
		}
	}
}