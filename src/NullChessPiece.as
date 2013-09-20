package src {
	
	/** @author Kristian Welsh */
	public class NullChessPiece extends ChessPiece {
		public function NullChessPiece(x:Number, y:Number, type:int, black:Boolean, parent:Main):void {
			trace("foo");
			super(x, y, type, black, parent);
		}
		
		public override function updatePiece(type:int, black:Boolean):void {
			trace("bar");
			super.updatePiece(type, black);
		}
	}
}