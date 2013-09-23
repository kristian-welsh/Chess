package pieces {
	
	/** @author Kristian Welsh */
	public class Rook extends ChessPiece implements IChessPiece {
		public function Rook(x:Number, y:Number, type:int, black:Boolean, parent:Main):void {
			super(x, y, type, black, parent);
		}
		
		public function legalMoves():Array {
			U_tiles = foward(7);
			D_tiles = back(7);
			L_tiles = left(7);
			R_tiles = right(7);
			return loopVERTS(7);
		}
	}
}