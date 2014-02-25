package test {
	import asunit.framework.TestSuite;
	
	public class AllTests extends TestSuite {
		static public var mainReferance:Main;
		public function AllTests() {
			addTest(new CursorTest("test_construction", mainReferance));
			addTest(new CursorTest("test_moving_mouse_off_board_makes_cursor_invisible", mainReferance));
			addTest(new CursorTest("test_moving_mouse_changes_cursor_position_properly", mainReferance));
		}
	}
}