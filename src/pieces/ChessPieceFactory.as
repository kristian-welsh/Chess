package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class ChessPieceFactory {
		public static var CONTAINER:DisplayObjectContainer;
		
		// TODO: move these declarations to a dedicated constant class
		public static var NULL:Class = NullChessPiece;
		public static var PAWN:Class = Pawn;
		public static var ROOK:Class = Rook;
		public static var KNIGHT:Class = Knight;
		public static var BISHOP:Class = Bishop;
		public static var QUEEN:Class = Queen;
		public static var KING:Class = King;
		
		// TODO: replace type with enumerated string constants
		public static function makeChessPiece(type:Class, position:Point, black:Boolean, boardData:BoardData):IChessPiece {
			var piece:ChessPiece = createChessPiece(type, position, black, boardData);
			CONTAINER.addChild(piece);
			return piece;
		}
		
		private static function createChessPiece(type:Class, position:Point, black:Boolean, boardData:BoardData):ChessPiece {
			switch (type) {
				case NULL:
					return new NullChessPiece(position, black, boardData);
				case PAWN:
					return new Pawn(position, black, boardData);
				case ROOK:
					return new Rook(position, black, boardData);
				case KNIGHT:
					return new Knight(position, black, boardData);
				case BISHOP:
					return new Bishop(position, black, boardData);
				case QUEEN:
					return new Queen(position, black, boardData);
				case KING:
					return new King(position, black, boardData);
				default:
					throw new Error("Invalid value in parameter \"type\" in method createChessPiece. Valid values are subclasses of ChessPiece, value found to be: " + type);
			}
		}
	}
}