package test {
	import asunit.framework.TestSuite;
	
	public class AllTests extends TestSuite {
		static public var mainReferance:Main;
		public function AllTests() {
			mainReferance.enableFakeMousePosition();
			addTest(new CursorTest("test_construction", mainReferance));
			addTest(new CursorTest("test_moving_mouse_off_board_makes_cursor_invisible", mainReferance));
			addTest(new CursorTest("test_moving_mouse_changes_cursor_position_properly", mainReferance));
			addTest(new CursorTest("test_mouse_click_on_white_piece", mainReferance));
			addTest(new CursorTest("test_invalid_piece_selection", mainReferance));
		}
	}
}