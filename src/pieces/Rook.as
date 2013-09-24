package pieces {
	
	/** @author Kristian Welsh */
	public class Rook extends ChessPiece implements IChessPiece {
		public function Rook(x:Number, y:Number, black:Boolean, parent:Main):void {
			super(x, y, 2, black, parent);
		}
		
		public function legalMoves():Array {
			_upTiles = up(7);
			_downTiles = down(7);
			_leftTiles = left(7);
			_rightTiles = right(7);
			return loopVerticals(7);
		}
	}
}