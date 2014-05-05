package pieces {
	import pieces.specified.*;
	// rename to ChessPieceType
	public class ChessPieceTypes {
		// make them all instances of ChessPieceTypes
		static public const NULL:Class = NullChessPiece;
		static public const TESTABLE:Class = TestableChessPiece;
		static public const PAWN:Class = Pawn;
		static public const ROOK:Class = Rook;
		static public const KNIGHT:Class = Knight;
		static public const BISHOP:Class = Bishop;
		static public const QUEEN:Class = Queen;
		static public const KING:Class = King;
	}
}