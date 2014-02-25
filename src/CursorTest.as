package {
	import asunit.framework.TestCase;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import test.FakeSprite;
	
	
	public class CursorTest extends TestCase {
		private static const TILE_QUANTATY_WIDTH:Number = 8
		private static const TILE_SIZE:Number = 36
		private static const BORDER_WIDTH:Number = 12
		
		private var container:FakeSprite;
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
			assertMouseMovePosition(new Point(BORDER_WIDTH, BORDER_WIDTH), new Point(BORDER_WIDTH + TILE_SIZE - 1, BORDER_WIDTH + TILE_SIZE - 1));
			assertMouseMovePosition(new Point(BORDER_WIDTH + TILE_SIZE, BORDER_WIDTH + TILE_SIZE), new Point(BORDER_WIDTH + TILE_SIZE, BORDER_WIDTH + TILE_SIZE));
			
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
			cursor.x = NaN;
			cursor.y = NaN;
			
			moveMouse(moveTo);
			assertEquals(expectedPos.x, cursor.x);
			assertEquals(expectedPos.y, cursor.y);
			
			cursor.x = prevX;
			cursor.y = prevY;
		}
		
		private function moveMouse(position:Object = null):void {
			if (position.x)
				container.mouseX = position.x;
			if (position.y)
				container.mouseY = position.y;
			container.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
		}
	}
}