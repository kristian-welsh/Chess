package pieces {
	
	/** @author Kristian Welsh */
	public class Queen extends ChessPiece implements IChessPiece {
		public function Queen(x:Number, y:Number, black:Boolean, parent:Main):void {
			super(x, y, 5, black, parent);
		}
		
		public function legalMoves():Array {
			_upTiles = foward(7);
			_downTiles = back(7);
			_leftTiles = left(7);
			_rightTiles = right(7);
			UL_tiles = UL(7);
			UR_tiles = UR(7);
			DL_tiles = DL(7);
			DR_tiles = DR(7);
			return loopVERTS(7).concat(loopDIAGS(7));
		}
	}
}