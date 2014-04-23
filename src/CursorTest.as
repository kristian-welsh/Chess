package {
	import asunit.framework.TestCase;
	import board.BoardInfo;
	import board.InMemoryBoardData;
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.geom.Point;
	import flash.utils.Timer;
	import pieces.*;
	import rawdata.RawTestData;
	import test.FakeSprite;
	
	public class CursorTest extends TestCase {
		private static const BOARD_WIDTH:Number = BoardInfo.BOARD_WIDTH;
		private static const TILE_WIDTH:Number = BoardInfo.TILE_WIDTH;
		private static const BORDER_WIDTH:Number = BoardInfo.BORDER_WIDTH;
		
		private var cursor:Cursor;
		private var container:FakeSprite;
		private var boardData:InMemoryBoardData;
		
		public function CursorTest(testName:String) {
			super(testName);
		}
		
		protected override function setUp():void {
			container = new FakeSprite();
			container.addChild(new ChessBoard()); //blows up if this isn't added
			container.enableFakeMousePosition();
			boardData = new InMemoryBoardData(RawTestData.data); // TODO: substitute in a fake BoardData object
			cursor = new Cursor(boardData, container);
		}
		
		public function test_construction():void {
			assertFalse(cursor.visible);
		}
		
		public function test_moving_mouse_off_board_makes_cursor_invisible():void {
			assertMouseMoveVisibility(false, new Point(BORDER_WIDTH - 1, BORDER_WIDTH));
			assertMouseMoveVisibility(false, new Point(BORDER_WIDTH, BORDER_WIDTH - 1));
			assertMouseMoveVisibility(true, new Point(BORDER_WIDTH, BORDER_WIDTH));
			
			var justInsideBoard:Number = BOARD_WIDTH * TILE_WIDTH + BORDER_WIDTH - 1
			assertMouseMoveVisibility(true, new Point(justInsideBoard, justInsideBoard));
			assertMouseMoveVisibility(false, new Point(justInsideBoard + 1, justInsideBoard));
			assertMouseMoveVisibility(false, new Point(justInsideBoard, justInsideBoard + 1));
		}
		
		public function test_moving_mouse_changes_cursor_position_properly():void {
			assertMouseMoves(worldPositionOfTile(0, 0), new Point(BORDER_WIDTH + TILE_WIDTH - 1, BORDER_WIDTH + TILE_WIDTH - 1));
			assertMouseMoves(worldPositionOfTile(1, 1), worldPositionOfTile(1, 1));
			
			cursor.gotoAndStop(2);
			cursor.x = 0;
			cursor.y = 0;
			moveMouse(new Point(123, 123));
			assertEquals(0, cursor.x);
			assertEquals(0, cursor.y);
		}
		
		public function test_clicking_on_white_piece_twice():void {
			setPieceSelectedFalse();
			clickBoardTile(0, 6); // white piece
			assertTileSelected(0, 6);
			assertEquals(3, container.numChildren);
			clickBoardTile(0, 6); // same white piece
			assertTileHoveredButNotSelected(0, 6);
			assertEquals(1, container.numChildren);
		}
		
		public function test_legal_move_indicator_state():void {
			clickBoardTile(0, 6); // white piece (pawn)
			
			var validMove1:DisplayObject = container.getChildAt(2);
			assertEquals(worldPosition(0), validMove1.x);
			assertEquals(worldPosition(5), validMove1.y);
			var validMove2:DisplayObject = container.getChildAt(1);
			assertEquals(worldPosition(0), validMove2.x);
			assertEquals(worldPosition(4), validMove2.y);
		}
		
		public function test_make_move():void {
			var originalEmptySpace:DisplayObject = boardData.getChessPieceAt(0, 5) as DisplayObject;
			var originalChessPiece:DisplayObject = boardData.getChessPieceAt(0, 6) as DisplayObject;
			assertTrue(originalChessPiece.parent);
			
			clickBoardTile(0, 6); // white piece (pawn)
			click(container.getChildAt(2)); // legal move indicator one space in front of pawn
			assertEquals(1, container.numChildren);
			assertFalse(originalEmptySpace.parent);
			assertFalse(originalChessPiece.parent);
			var newEmptySpace:IChessPiece = boardData.getChessPieceAt(0, 5);
			var newChessPiece:IChessPiece = boardData.getChessPieceAt(0, 6);
			assertEquals(Pawn, newEmptySpace.type);
			assertEquals(NullChessPiece, newChessPiece.type);
			assertFalse(newEmptySpace.colour == ChessPieceColours.BLACK);
			assertTrue(newChessPiece.colour == ChessPieceColours.BLACK);
		}
		
		private function click(object:DisplayObject):void {
			object.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		public function test_mid_selection_interactions():void {
			setPieceSelectedFalse();
			clickBoardTile(0, 6); // white piece (pawn)
			assertTileSelected(0, 6);
			clickBoardTile(0, 0); // black piece
			assertTileSelected(0, 6);
			clickBoardTile(0, 1); // empty space
			assertTileSelected(0, 6);
			clickBoardTile(1, 6); // other white piece
			assertTileHoveredButNotSelected(1, 6);
		}
		
		public function test_invalid_piece_selection():void {
			setPieceSelectedFalse();
			clickBoardTile(0, -1); // square off board
			assertNoPieceSelected();
			clickBoardTile(0, 2); // empty square
			assertNoPieceSelected();
			clickBoardTile(0, 0); // black piece
			assertNoPieceSelected();
		}
		
		// BUG: This test documents a current bug in the system. Inspect this behaviorur further if this test fails, as the bug may be gone.
		public function test_soon_after_movement_select_piece_fails():void {
			clickBoardTile(0, 6); // white piece (pawn)
			click(container.getChildAt(2)); // legal move indicator one space in front of pawn
			clickBoardTile(0, 5); // white piece (pawn)
			assertNoPieceSelected();
		}
		
		public function test_second_move_after_while_succeeds():void {
			clickBoardTile(0, 6); // white piece (pawn)
			click(container.getChildAt(2)); // legal move indicator one space in front of pawn
			
			callFunctionAfterTimeout(1, function() {
					clickBoardTile(0, 5); // white piece (pawn)
					assertTrue(cursorPieceSelected());
				});
		}
		
		// TODO: Refactor to use Util::delayCall
		private function callFunctionAfterTimeout(timeout:uint, functionToCall:Function):void {
			var timer:Timer = new Timer(timeout, 1);
			var callIt:Function = function(e:Event) {
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handler);
				functionToCall();
			}
			var handler:Function = addAsync(callIt, timeout + 10);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, handler);
			timer.start();
		}
		
		private function cursorPieceSelected():Boolean {
			return (cursor.currentFrame == 2) ? true : false;
		}
		
		private function clickBoardTile(rowNumber:int, columnNumber:int):void {
			moveMouseToTile(rowNumber, columnNumber);
			clickMouse();
		}
		
		private function moveMouseToTile(rowNumber:int, columnNumber:int):void {
			moveMouse(worldPositionOfTile(rowNumber, columnNumber));
		}
		
		private function setPieceSelectedFalse():void {
			cursor.gotoAndStop(1);
		}
		
		private function setPieceSelectedTrue():void {
			cursor.gotoAndStop(2);
		}
		
		private function worldPositionOfTile(rowNumber:int, columnNumber:int):Point {
			return new Point(worldPosition(rowNumber), worldPosition(columnNumber));
		}
		
		private function worldPosition(tileNumber:int):int {
			return BORDER_WIDTH + tileNumber * TILE_WIDTH;
		}
		
		private function moveMouse(position:Point):void {
			container.mouseX = position.x;
			container.mouseY = position.y;
			container.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
		}
		
		private function clickMouse():void {
			container.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		private function assertTileHoveredButNotSelected(rowNumber:int, columnNumber:int):void {
			assertCursorOverTile(rowNumber, columnNumber);
			assertNoPieceSelected();
		}
		
		private function assertTileSelected(rowNumber:int, columnNumber:int):void {
			assertCursorOverTile(rowNumber, columnNumber);
			assertAnyPieceSelected();
		}
		
		private function assertAnyPieceSelected():void {
			assertTrue(cursorPieceSelected());
		}
		
		private function assertNoPieceSelected():void {
			assertFalse(cursorPieceSelected());
		}
		
		private function assertCursorOverTile(rowNumber:int, columnNumber:int):void {
			assertEquals(BORDER_WIDTH + rowNumber * TILE_WIDTH, cursor.x);
			assertEquals(BORDER_WIDTH + columnNumber * TILE_WIDTH, cursor.y);
		}
		
		private function assertMouseMoveVisibility(expectedState:Boolean, position:Point = null) {
			cursor.visible = !expectedState
			moveMouse(position);
			assertTrue(cursor.visible == expectedState);
		}
		
		private function assertMouseMoves(expectedPos:Point, moveTo:Point) {
			var prevX:Number = cursor.x;
			var prevY:Number = cursor.y;
			//set position no NaN to make sure that cursor didn't just happen to already be in the right position.
			cursor.x = NaN;
			cursor.y = NaN;
			
			moveMouse(moveTo);
			assertEquals(expectedPos.x, cursor.x);
			assertEquals(expectedPos.y, cursor.y);
			
			cursor.x = prevX;
			cursor.y = prevY;
		}
	}
}