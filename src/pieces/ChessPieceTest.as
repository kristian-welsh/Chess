package pieces {
	import asunit.framework.TestCase;
	import board.BoardData;
	import board.InMemoryBoardData;
	import flash.geom.Point;
	import rawdata.RawTestData;

	public class ChessPieceTest extends TestCase {
		private var piece:TestableChessPiece;
		
		public function ChessPieceTest(method:String) {
			super(method);
		}
		
		override protected function setUp():void {
			var boardData:InMemoryBoardData = new InMemoryBoardData(RawTestData.data);
			piece = new TestableChessPiece(new Point(1, 2), ChessPieceColours.BLACK, boardData);
		}
		
		public function proper_frame_selection():void {
			assertEquals(2, piece.getFunctionCallAt(0).getArgByPosition(0));
			piece = new TestableChessPiece(new Point(1, 2), ChessPieceColours.WHITE, new InMemoryBoardData(RawTestData.data));
			assertEquals(1, piece.getFunctionCallAt(0).getArgByPosition(0));
		}
		
		public function constructor_positions_piece_correctly():void {
			assertEquals(1, piece.tileX);
			assertEquals(2, piece.tileY);
		}
		
		public function should_return_type_and_black_correctly_before_input():void {
			assertEquals(null, piece.type);
			assertTrue(piece.colour == ChessPieceColours.BLACK);
		}
		
		public function characterisation():void {
			var length:uint = piece.superPathLength(1, 0, -1);
			assertEquals(1, length);
		}
	}
}