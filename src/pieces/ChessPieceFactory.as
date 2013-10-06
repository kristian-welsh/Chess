package pieces {
	
	/** @author Kristian Welsh */
	public class ChessPieceFactory {
		
		// todo: replace type with enumerated string constants
		
		public static function makeChessPiece(type:int, x:Number, y:Number, black:Boolean, parent:Main):IChessPiece {
			switch(type) {
				default:
				case 0:
					return new NullChessPiece(x, y, black, parent);
				case 1:
					return new Pawn(x, y, black, parent);
				case 2:
					return new Rook(x, y, black, parent);
				case 3:
					return new Knight(x, y, black, parent);
				case 4:
					return new Bishop(x, y, black, parent);
				case 5:
					return new Queen(x, y, black, parent);
				case 6:
					return new King(x, y, black, parent);
			}
			throw new Error("Should Not Reach This Point");
		}
		
		public static function cloneChessPiece(source:IChessPiece, parent:Main):IChessPiece {
			return makeChessPiece(source.type, source.x, source.y, source.black, parent);
		}
	}
}