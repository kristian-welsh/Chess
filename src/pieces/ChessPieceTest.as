package pieces {
	import asunit.framework.TestCase;
	import board.InMemoryBoardData;
	import flash.geom.Point;
	import pieces.specified.Pawn;
	import pieces.specified.TestableChessPiece;
	import rawdata.EmptyBoard;
	import rawdata.RawTestData;
	
	public class ChessPieceTest extends TestCase {
		private var piece:TestableChessPiece;
		
		public function ChessPieceTest(method:String) {
			super(method);
		}
		
		override protected function setUp():void {
			var boardData:InMemoryBoardData = new InMemoryBoardData();
			boardData.organizeRawChessData(EmptyBoard.data);
			boardData.addPieceToBoard(new Pawn(new Point(0, 0), ChessPieceColour.BLACK, boardData));
			boardData.addPieceToBoard(new Pawn(new Point(0, 6), ChessPieceColour.WHITE, boardData));
			boardData.addPieceToBoard(new Pawn(new Point(1, 6), ChessPieceColour.WHITE, boardData));
			piece = new TestableChessPiece(new Point(1, 2), ChessPieceColour.BLACK, boardData);
		}
		
		public function proper_frame_selection():void {
			assertEquals(2, piece.getFunctionCallAt(0).getArgByPosition(0));
			var boardData:InMemoryBoardData = new InMemoryBoardData();
			boardData.organizeRawChessData(RawTestData.data);
			piece = new TestableChessPiece(new Point(1, 2), ChessPieceColour.WHITE, boardData);
			assertEquals(1, piece.getFunctionCallAt(0).getArgByPosition(0));
		}
		
		public function constructor_positions_piece_correctly():void {
			assertEquals(1, piece.tileX);
			assertEquals(2, piece.tileY);
		}
		
		public function should_return_type_and_colour_correctly_before_input():void {
			assertEquals(null, piece.type);
			assertTrue(piece.colour == ChessPieceColour.BLACK);
		}
		
		public function characterisation():void {
			var length:uint = piece.superPathLength(1, 0, -1);
			assertEquals(1, length);
		}
	}
}