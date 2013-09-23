package pieces {
	
	/** @author Kristian Welsh */
	public class ChessPieceFactory {
		public static function makeChessPiece(x:Number, y:Number, type:int, black:Boolean, parent:Main):IChessPiece {
			switch(type) {
				default:
				case 0:
					return new NullChessPiece(x, y, type, black, parent);
				case 1:
					return new Pawn(x, y, type, black, parent);
				case 2:
					return new Rook(x, y, type, black, parent);
				case 3:
					return new Knight(x, y, type, black, parent);
				case 4:
					return new Bishop(x, y, type, black, parent);
				case 5:
					return new Queen(x, y, type, black, parent);
				case 6:
					return new King(x, y, type, black, parent);
			}
			throw new Error("Should Not Reach This Point");
		}
	}
}