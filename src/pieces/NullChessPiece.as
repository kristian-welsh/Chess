package pieces {
	
	/** @author Kristian Welsh */
	public class NullChessPiece extends ChessPiece implements IChessPiece {
		public function NullChessPiece(x:Number, y:Number, black:Boolean, parent:Main):void {
			super(x, y, 0, black, parent);
			this.visible = false;
		}
		
		public function legalMoves():Array {
			return [];
		}
	}
}