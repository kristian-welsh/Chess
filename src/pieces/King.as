package pieces {
	
	/** @author Kristian Welsh */
	public class King extends ChessPiece implements IChessPiece {
		public function King(x:Number, y:Number, type:int, black:Boolean, parent:Main):void {
			super(x, y, type, black, parent);
		}
		
		public function legalMoves():Array {
			U_tiles = foward(7);
			D_tiles = back(7);
			L_tiles = left(7);
			R_tiles = right(7);
			UL_tiles = UL(7);
			UR_tiles = UR(7);
			DL_tiles = DL(7);
			DR_tiles = DR(7);
			var VERTS:Array = loopVERTS(1);
			var DIAGS:Array = loopDIAGS(1);
			var i:int;
			var return_me:Array = []
			
			for (i = 0; i < VERTS.length; i++) {
				return_me.push(VERTS[i]);
			}
			for (i = 0; i < DIAGS.length; i++) {
				return_me.push(DIAGS[i]);
			}
			return return_me;
		}
	}
}