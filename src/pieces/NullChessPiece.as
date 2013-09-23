package pieces {
	
	/** @author Kristian Welsh */
	public class NullChessPiece extends ChessPiece implements IChessPiece {
		public function NullChessPiece(x:Number, y:Number, type:int, black:Boolean, parent:Main):void {
			super(x, y, type, black, parent);
		}
		
		public function legalMoves():Array {
			return [];
		}
	}
}