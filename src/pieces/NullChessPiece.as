package pieces {
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class NullChessPiece extends ChessPiece implements IChessPiece {
		public function NullChessPiece(position:Point, black:Boolean, parent:Main):void {
			super(position, 0, black, parent);
			this.visible = false;
		}
		
		public function legalMoves():Array {
			return [];
		}
	}
}