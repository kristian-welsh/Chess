package pieces {
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class ChessPieceFactory {
		public static var MAIN:Main;
		// TODO: replace type with enumerated string constants
		public static function makeChessPiece(type:uint, position:Point, black:Boolean):IChessPiece {
			switch(type) {
				case 0:
					return new NullChessPiece(position, black, MAIN);
				case 1:
					return new Pawn(position, black, MAIN);
				case 2:
					return new Rook(position, black, MAIN);
				case 3:
					return new Knight(position, black, MAIN);
				case 4:
					return new Bishop(position, black, MAIN);
				case 5:
					return new Queen(position, black, MAIN);
				case 6:
					return new King(position, black, MAIN);
				default:
					throw new Error("Invalid value in parameter \"type\" in method makeChessPiece. Valid values are integers from 0 to 6, value found to be: " + type);
			}
			throw new Error("Should not reach this statement in method makeChessPiece");
		}
		
		public static function cloneChessPiece(source:IChessPiece, parent:Main = null):IChessPiece {
			return makeChessPiece(source.type, new Point(source.x, source.y), source.black);
		}
	}
}