package pieces {
	
	/** @author Kristian Welsh */
	public class ChessPieceFactory {
		// todo: replace type with enumerated string constants
		public static var MAIN:Main;
		public static function makeChessPiece(type:uint, x:Number, y:Number, black:Boolean, parent:Main = null):IChessPiece {
			switch(type) {
				case 0:
					return new NullChessPiece(x, y, black, MAIN);
				case 1:
					return new Pawn(x, y, black, MAIN);
				case 2:
					return new Rook(x, y, black, MAIN);
				case 3:
					return new Knight(x, y, black, MAIN);
				case 4:
					return new Bishop(x, y, black, MAIN);
				case 5:
					return new Queen(x, y, black, MAIN);
				case 6:
					return new King(x, y, black, MAIN);
				default:
					throw new Error("Invalid value in parameter \"type\" in method makeChessPiece. Valid values are integers from 0 to 6, value found to be: " + type);
			}
			throw new Error("Should not reach this statement in method makeChessPiece");
		}
		
		public static function cloneChessPiece(source:IChessPiece, parent:Main = null):IChessPiece {
			return makeChessPiece(source.type, source.x, source.y, source.black);
		}
	}
}