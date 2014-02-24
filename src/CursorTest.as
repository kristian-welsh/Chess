package  {
	import asunit.framework.TestCase;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	

	public class CursorTest extends TestCase {
		private var container:DisplayObjectContainer;
		private var cursor:Cursor;
		
		public function CursorTest(string:String) {
			super(string);
		}
		
		protected override function setUp():void {
			container = new Sprite()
			cursor = new Cursor(container);
		}
		
		protected override function tearDown():void {
			container = null;
			cursor = null;
		}
		
		public function test_construction():void {
			assertTrue(container.contains(cursor));
			assertFalse(cursor.visible);
		}
		
		public function test_mouse_move():void {
			container.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
		}
	}
}