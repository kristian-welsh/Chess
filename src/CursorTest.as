package {
	import asunit.framework.TestCase;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class CursorTest extends TestCase {
		private static const TILE_QUANTATY_WIDTH:Number = 8
		private static const TILE_SIZE:Number = 36
		private static const BORDER_WIDTH:Number = 12
		
		private var container:Main;
		private var cursor:Cursor;
		
		public function CursorTest(string:String, main:Main) {
			this.container = main;
			super(string);
		}
		
		protected override function setUp():void {
			cursor = new Cursor(container);
		}
		
		protected override function tearDown():void {
			cursor = null;
			container = null;
		}
		
		public function test_construction():void {
			assertTrue(container.contains(cursor));
			assertFalse(cursor.visible);
		}
		
		public function test_moving_mouse_off_board_makes_cursor_invisible():void {
			assertMouseMoveVisibility(false, new Point(BORDER_WIDTH - 1, BORDER_WIDTH));
			assertMouseMoveVisibility(false, new Point(BORDER_WIDTH, BORDER_WIDTH - 1));
			assertMouseMoveVisibility(true, new Point(BORDER_WIDTH, BORDER_WIDTH));
			
			var justInsideBoard:Number = TILE_QUANTATY_WIDTH * TILE_SIZE + BORDER_WIDTH - 1
			assertMouseMoveVisibility(true, new Point(justInsideBoard, justInsideBoard));
			assertMouseMoveVisibility(false, new Point(justInsideBoard + 1, justInsideBoard));
			assertMouseMoveVisibility(false, new Point(justInsideBoard, justInsideBoard + 1));
		}
		
		private function assertMouseMoveVisibility(expectedState:Boolean, position:Point = null) {
			cursor.visible = !expectedState
			moveMouse(position);
			assertTrue(cursor.visible == expectedState);
		}
		
		public function test_moving_mouse_changes_cursor_position_properly():void {
			assertMouseMovePosition(worldPositionOfTile(0, 0), new Point(BORDER_WIDTH + TILE_SIZE - 1, BORDER_WIDTH + TILE_SIZE - 1));
			assertMouseMovePosition(worldPositionOfTile(1, 1), worldPositionOfTile(1, 1));
			
			cursor.gotoAndStop(2);
			cursor.x = 0;
			cursor.y = 0;
			moveMouse(new Point(123, 123));
			assertEquals(0, cursor.x);
			assertEquals(0, cursor.y);
		}
		
		private function assertMouseMovePosition(expectedPos:Point, moveTo:Point = null) {
			var prevX:Number = cursor.x;
			var prevY:Number = cursor.y;
			//set position no NaN to make sure that cursor diidn't happen to already be in the right position.
			cursor.x = NaN;
			cursor.y = NaN;
			
			moveMouse(moveTo);
			assertEquals(expectedPos.x, cursor.x);
			assertEquals(expectedPos.y, cursor.y);
			
			cursor.x = prevX;
			cursor.y = prevY;
		}
		
		public function test_mouse_click_on_white_piece():void {
			moveMouse(worldPositionOfTile(0, 6));
			assertEquals(12, cursor.x);
			assertEquals(228, cursor.y);
			setPieceSelectedFalse();
			
			//probable bug: adds 6 children when selecting for the first time, removes only 4 when de-selecting
			assertEquals(68, container.numChildren);
			clickMouse();
			assertTrue(cursorPieceSelected());
			assertEquals(74, container.numChildren);
			clickMouse();
			assertFalse(cursorPieceSelected());
			assertEquals(70, container.numChildren);
			clickMouse();
			moveMouse(worldPositionOfTile(1, 1));
			assertEquals(12, cursor.x);
			assertEquals(228, cursor.y);
			clickMouse();
			assertTrue(cursorPieceSelected());
		}
		
		public function test_invalid_piece_selection():void {
			setPieceSelectedFalse();
			moveMouse(worldPositionOfTile(0, 5));
			clickMouse();
			assertFalse(cursorPieceSelected());
		}
		
		private function cursorPieceSelected():Boolean {
			return (cursor.currentFrame == 2) ? true : false;
		}
		
		private function moveMouse(position:Point):void {
			container.mouseX = position.x;
			container.mouseY = position.y;
			container.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
		}
		
		private function clickMouse():void {
			container.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		private function setPieceSelectedFalse():void {
			cursor.gotoAndStop(1);
		}
		
		private function setPieceSelectedTrue():void {
			cursor.gotoAndStop(2);
		}
		
		private function worldPositionOfTile(tileI:int, tileJ:int):Point {
			return new Point(BORDER_WIDTH + tileI * TILE_SIZE, BORDER_WIDTH + tileJ * TILE_SIZE);
		}
	}
}