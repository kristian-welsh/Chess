package pieces {
	
	/** @author Kristian Welsh */
	public class Bishop extends ChessPiece implements IChessPiece {
		public function Bishop(x:Number, y:Number, black:Boolean, parent:Main):void {
			super(x, y, 4, black, parent);
		}
		
		public function legalMoves():Array {
			UL_tiles = UL(7);
			UR_tiles = UR(7);
			DL_tiles = DL(7);
			DR_tiles = DR(7);
			return loopDIAGS(7);
		}
	}
}