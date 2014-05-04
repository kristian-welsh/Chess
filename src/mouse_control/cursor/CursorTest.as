package mouse_control.cursor {
	import asunit.framework.TestCase;
	import board.*;
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.geom.Point;
	import flash.utils.Timer;
	import mouse_control.cursor.view.*;
	import pieces.*;
	import pieces.specified.*;
	import rawdata.RawTestData;
	import test.FakeSprite;
	
	public class CursorTest extends TestCase {
		private static const BOARD_WIDTH:Number = BoardInfo.BOARD_WIDTH;
		private static const TILE_WIDTH:Number = BoardInfo.TILE_WIDTH;
		private static const BORDER_WIDTH:Number = BoardInfo.BORDER_WIDTH;
		
		private var cursorView:CursorView;
		private var cursor:Cursor;
		private var container:FakeSprite;
		private var boardData:InMemoryBoardData;
		
		public function CursorTest(testName:String) {
			super(testName);
		}
		
		protected override function setUp():void {
			container = new FakeSprite();
			container.enableFakeMousePosition();
			boardData = new InMemoryBoardData(); // TODO: substitute in a fake BoardData object
			boardData.organizeRawChessData(RawTestData.data);
			cursorView = new CursorBitmapView();
			cursor = new Cursor(boardData, container, cursorView);
		}
		
		public function test_construction():void {
			assertFalse(cursorView.visible);
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
			
			cursorView.setSelected();
			cursorView.x = 0;
			cursorView.y = 0;
			moveMouse(new Point(123, 123));
			assertEquals(0, cursorView.x);
			assertEquals(0, cursorView.y);
		}
		
		public function test_clicking_on_white_piece_twice():void {
			setPieceSelectedFalse();
			clickBoardTile(0, 6); // white piece
			assertTileSelected(0, 6);
			assertEquals(2, container.numChildren);
			clickBoardTile(0, 6); // same white piece
			assertTileHoveredButNotSelected(0, 6);
			assertEquals(0, container.numChildren);
		}
		
		public function test_legal_move_indicator_state():void {
			clickBoardTile(0, 6); // white piece (pawn)
			
			var validMove1:DisplayObject = container.getChildAt(1);
			assertEquals(worldPosition(0), validMove1.x);
			assertEquals(worldPosition(5), validMove1.y);
			var validMove2:DisplayObject = container.getChildAt(0);
			assertEquals(worldPosition(0), validMove2.x);
			assertEquals(worldPosition(4), validMove2.y);
		}
		
		public function test_make_move():void {
			var originalEmptySpace:DisplayObject = boardData.getChessPieceAt(0, 5) as DisplayObject;
			var originalChessPiece:DisplayObject = boardData.getChessPieceAt(0, 6) as DisplayObject;
			assertTrue(originalChessPiece.parent);
			
			clickBoardTile(0, 6); // white piece (pawn)
			click(container.getChildAt(1)); // legal move indicator one space in front of pawn
			assertEquals(0, container.numChildren);
			assertFalse(originalEmptySpace.parent);
			assertFalse(originalChessPiece.parent);
			var newEmptySpace:IChessPiece = boardData.getChessPieceAt(0, 5);
			var newChessPiece:IChessPiece = boardData.getChessPieceAt(0, 6);
			assertEquals(Pawn, newEmptySpace.type);
			assertEquals(NullChessPiece, newChessPiece.type);
			assertFalse(newEmptySpace.colour == ChessPieceColour.BLACK);
			assertTrue(newChessPiece.colour == ChessPieceColour.NONE);
		}
		
		private function click(object:DisplayObject):void {
			Util.click(object);
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
			click(container.getChildAt(1)); // legal move indicator one space in front of pawn
			clickBoardTile(0, 5); // white piece (pawn)
			assertNoPieceSelected();
		}
		
		public function test_second_move_after_while_succeeds():void {
			clickBoardTile(0, 6); // white piece (pawn)
			click(container.getChildAt(1)); // legal move indicator one space in front of pawn
			
			callFunctionAfterTimeout(1, function() {
					clickBoardTile(0, 5); // white piece (pawn)
					assertTrue(cursorPieceSelected());
				});
		}
		
		// very similar to, but incompatable with Util.delayCall, as i need to pass the event to handler, which delayCall shouldn't do.
		// possibly try to merge the two in the future?
		private function callFunctionAfterTimeout(timeout:uint, functionToCall:Function):void {
			var timer:Timer = new Timer(timeout, 1);
			var callIt:Function = function(e:Event) {
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handler);
				functionToCall();
			}
			var handler:Function = addAsync(callIt, timeout + 100);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, handler);
			timer.start();
		}
		
		private function cursorPieceSelected():Boolean {
			return cursorView.pieceSelected();
		}
		
		private function clickBoardTile(rowNumber:int, columnNumber:int):void {
			moveMouseToTile(rowNumber, columnNumber);
			click(container);
		}
		
		private function moveMouseToTile(rowNumber:int, columnNumber:int):void {
			moveMouse(worldPositionOfTile(rowNumber, columnNumber));
		}
		
		private function setPieceSelectedFalse():void {
			cursorView.setNotSelected();
		}
		
		private function setPieceSelectedTrue():void {
			cursorView.setSelected();
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
			assertEquals(BORDER_WIDTH + rowNumber * TILE_WIDTH, cursorView.x);
			assertEquals(BORDER_WIDTH + columnNumber * TILE_WIDTH, cursorView.y);
		}
		
		private function assertMouseMoveVisibility(expectedState:Boolean, position:Point = null) {
			(expectedState) ? cursorView.hide() : cursorView.show();
			moveMouse(position);
			assertTrue(cursorView.visible == expectedState);
		}
		
		private function assertMouseMoves(expectedPos:Point, moveTo:Point) {
			var prevX:Number = cursorView.x;
			var prevY:Number = cursorView.y;
			//set position no NaN to make sure that cursor didn't just happen to already be in the right position.
			cursorView.x = NaN;
			cursorView.y = NaN;
			
			moveMouse(moveTo);
			assertEquals(expectedPos.x, cursorView.x);
			assertEquals(expectedPos.y, cursorView.y);
			
			cursorView.x = prevX;
			cursorView.y = prevY;
		}
	}
}