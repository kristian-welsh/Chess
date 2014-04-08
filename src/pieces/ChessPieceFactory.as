package pieces {
	import board.BoardData;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class ChessPieceFactory {
		public static var MAIN:Main;
		// TODO: replace type with enumerated string constants
		public static function makeChessPiece(type:uint, position:Point, black:Boolean, boardData:BoardData):IChessPiece {
			switch(type) {
				case 0:
					return new NullChessPiece(position, black, MAIN, boardData);
				case 1:
					return new Pawn(position, black, MAIN, boardData);
				case 2:
					return new Rook(position, black, MAIN, boardData);
				case 3:
					return new Knight(position, black, MAIN, boardData);
				case 4:
					return new Bishop(position, black, MAIN, boardData);
				case 5:
					return new Queen(position, black, MAIN, boardData);
				case 6:
					return new King(position, black, MAIN, boardData);
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