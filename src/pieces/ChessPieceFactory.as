package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class ChessPieceFactory {
		public static var CONTAINER:DisplayObjectContainer;
		
		public static var NULL:Class = NullChessPiece;
		public static var PAWN:Class = Pawn;
		public static var ROOK:Class = Rook;
		public static var KNIGHT:Class = Knight;
		public static var BISHOP:Class = Bishop;
		public static var QUEEN:Class = Queen;
		public static var KING:Class = King;
		
		// TODO: replace type with enumerated string constants
		public static function makeChessPiece(type:Class, position:Point, black:Boolean, boardData:BoardData):IChessPiece {
			switch (type) {
				case NULL:
					return new NullChessPiece(position, black, CONTAINER, boardData);
				case PAWN:
					return new Pawn(position, black, CONTAINER, boardData);
				case ROOK:
					return new Rook(position, black, CONTAINER, boardData);
				case KNIGHT:
					return new Knight(position, black, CONTAINER, boardData);
				case BISHOP:
					return new Bishop(position, black, CONTAINER, boardData);
				case QUEEN:
					return new Queen(position, black, CONTAINER, boardData);
				case KING:
					return new King(position, black, CONTAINER, boardData);
				default:
					throw new Error("Invalid value in parameter \"type\" in method makeChessPiece. Valid values are integers from 0 to 6, value found to be: " + type);
			}
			throw new Error("Should not reach this statement in method makeChessPiece");
		}
		
		public static function cloneChessPiece(source:IChessPiece, boardData:BoardData):IChessPiece {
			return makeChessPiece(source.type, new Point(source.x, source.y), source.black, boardData);
		}
	}
}