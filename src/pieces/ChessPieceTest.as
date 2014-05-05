package pieces {
	import asunit.framework.TestCase;
	import board.BoardInfo;
	import board.InMemoryBoardData;
	import flash.geom.Point;
	import pieces.specified.TestableChessPiece;
	import rawdata.EmptyBoard;
	
	public class ChessPieceTest extends TestCase {
		private var piece:TestableChessPiece;
		private var boardData:InMemoryBoardData = new InMemoryBoardData();
		
		public function ChessPieceTest(method:String) {
			super(method);
		}
		
		override protected function setUp():void {
			boardData.organizeRawChessData(EmptyBoard.data);
		}
		
		public function proper_frame_selection():void {
			piece = newTestPiece(0, 0, ChessPieceColour.BLACK);
			assertEquals(2, piece.getFunctionCallAt(0).getArgByPosition(0));
			piece = newTestPiece(0, 0, ChessPieceColour.WHITE);
			assertEquals(1, piece.getFunctionCallAt(0).getArgByPosition(0));
		}
		
		public function constructor_positions_piece_correctly():void {
			piece = newTestPiece(1, 2, ChessPieceColour.BLACK);
			
			var correctXPosition:Number = 1 * BoardInfo.TILE_WIDTH + BoardInfo.BORDER_WIDTH;
			var correctYPosition:Number = 2 * BoardInfo.TILE_WIDTH + BoardInfo.BORDER_WIDTH;
			
			assertEquals(correctXPosition, piece.x);
			assertEquals(correctYPosition, piece.y);
		}
		
		public function should_return_colour_correctly_before_input():void {
			piece = newTestPiece(0, 0, ChessPieceColour.BLACK);
			assertTrue(piece.colour == ChessPieceColour.BLACK);
		}
		
		public function pathLengh_doesnt_extend_past_board_end():void {
			piece = newTestPiece(0, 0, ChessPieceColour.BLACK);
			assertEquals(0, piece.superPathLength(10, -1, 0));
			assertEquals(0, piece.superPathLength(10, 0, -1));
			assertEquals(7, piece.superPathLength(10, 0, 1));
			assertEquals(7, piece.superPathLength(10, 1, 0));
		}
		
		// for brevity these only test one direction
		// it is assumed that these propertys are direction independant
		public function pathLength_limits_its_return_to_the_passed_in_limit():void {
			piece = newTestPiece(3, 3, ChessPieceColour.BLACK);
			assertEquals(1, piece.superPathLength(1, 0, 0));
		}
		
		public function pathLength_stops_before_white_pieces():void {
			piece = newTestPiece(3, 3, ChessPieceColour.BLACK);
			boardData.addPieceToBoard(newPiece(3, 5, ChessPieceColour.WHITE));
			assertEquals(1, piece.superPathLength(2, 0, 1));
		}
		
		public function pathLength_stops_on_black_pieces():void {
			piece = newTestPiece(3, 3, ChessPieceColour.BLACK);
			boardData.addPieceToBoard(newPiece(3, 5, ChessPieceColour.BLACK));
			assertEquals(2, piece.superPathLength(2, 0, 1));
		}
		
		public function pathLength_rejects_invalid_input():void {
			piece = newTestPiece(0, 0, ChessPieceColour.BLACK);
			assertThrows(ChessPieceError, function() {
					piece.superPathLength(0, 5, 0);
				})
			assertThrows(ChessPieceError, function() {
					piece.superPathLength(0, 0, 5);
				})
		}
		
		private function newTestPiece(x:int, y:int, colour:ChessPieceColour):TestableChessPiece {
			return newPiece(x, y, colour, ChessPieceTypes.TESTABLE) as TestableChessPiece;
		}
		
		private function addPieceToBoard(x:int, y:int, colour:ChessPieceColour, type:Class = null):void {
			boardData.addPieceToBoard(newPiece(x, y, colour, type));
		}
		
		private function newPiece(x:int, y:int, colour:ChessPieceColour, type:Class = null):ChessPiece {
			type = type || ChessPieceTypes.PAWN;
			return ChessPieceFactory.makeChessPiece(type, new Point(x, y), colour, boardData) as ChessPiece;
		}
	}
}