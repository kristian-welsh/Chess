package pieces {
	
	/** @author Kristian Welsh */
	public class King extends ChessPiece implements IChessPiece {
		public function King(x:Number, y:Number, black:Boolean, parent:Main):void {
			super(x, y, 6, black, parent);
		}
		
		public function legalMoves():Array {
			_upTiles = foward(7);
			_downTiles = back(7);
			_leftTiles = left(7);
			_rightTiles = right(7);
			_upLeftTiles = upLeft(7);
			_upRightTiles = upRight(7);
			_downLeftTiles = downLeft(7);
			_downRightTiles = downRight(7);
			return loopVERTS(1).concat(loopDIAGS(1));
		}
	}
}