package src.pieces {
	import src.Main;
	
	/** @author Kristian Welsh */
	public class ChessPieceFactory {
		public static function makeChessPiece(x:Number, y:Number, type:int, black:Boolean, parent:Main):ChessPiece {
			switch(type) {
				default:
					return new ChessPiece(x, y, type, black, parent);
				case 0:
					return new NullChessPiece(x, y, type, black, parent);
			}
			throw new Error("Should Not Reach This Point");
		}
	}
}