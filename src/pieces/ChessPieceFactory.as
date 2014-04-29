package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import pieces.specified.*;
	
	public class ChessPieceFactory {
		public static var CONTAINER:DisplayObjectContainer;
		
		public static function makeChessPiece(type:Class, position:Point, colour:ChessPieceColour, boardData:BoardData):IChessPiece {
			var piece:ChessPiece = createChessPiece(type, position, colour, boardData);
			CONTAINER.addChild(piece);
			return piece;
		}
		
		private static function createChessPiece(type:Class, position:Point, colour:ChessPieceColour, boardData:BoardData):ChessPiece {
			switch (type) {
				case ChessPieceTypes.NULL:
					return new NullChessPiece(position, colour, boardData);
				case ChessPieceTypes.PAWN:
					return new Pawn(position, colour, boardData);
				case ChessPieceTypes.ROOK:
					return new Rook(position, colour, boardData);
				case ChessPieceTypes.KNIGHT:
					return new Knight(position, colour, boardData);
				case ChessPieceTypes.BISHOP:
					return new Bishop(position, colour, boardData);
				case ChessPieceTypes.QUEEN:
					return new Queen(position, colour, boardData);
				case ChessPieceTypes.KING:
					return new King(position, colour, boardData);
				default:
					throw new Error("Invalid value in parameter \"type\" in method createChessPiece. Valid values are subclasses of ChessPiece, value found to be: " + type);
			}
		}
	}
}