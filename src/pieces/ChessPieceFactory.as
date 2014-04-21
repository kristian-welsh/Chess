package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class ChessPieceFactory {
		public static var CONTAINER:DisplayObjectContainer;
		
		public static function makeChessPiece(type:Class, position:Point, black:Boolean, boardData:BoardData):IChessPiece {
			var piece:ChessPiece = createChessPiece(type, position, black, boardData);
			CONTAINER.addChild(piece);
			return piece;
		}
		
		private static function createChessPiece(type:Class, position:Point, black:Boolean, boardData:BoardData):ChessPiece {
			switch (type) {
				case ChessPieceTypes.NULL:
					return new NullChessPiece(position, black, boardData);
				case ChessPieceTypes.PAWN:
					return new Pawn(position, black, boardData);
				case ChessPieceTypes.ROOK:
					return new Rook(position, black, boardData);
				case ChessPieceTypes.KNIGHT:
					return new Knight(position, black, boardData);
				case ChessPieceTypes.BISHOP:
					return new Bishop(position, black, boardData);
				case ChessPieceTypes.QUEEN:
					return new Queen(position, black, boardData);
				case ChessPieceTypes.KING:
					return new King(position, black, boardData);
				default:
					throw new Error("Invalid value in parameter \"type\" in method createChessPiece. Valid values are subclasses of ChessPiece, value found to be: " + type);
			}
		}
	}
}