package test {
	import asunit.framework.TestSuite;
	
	public class AllTests extends TestSuite {
		static public var mainReferance:Main;
		public function AllTests() {
			mainReferance.enableFakeMousePosition();
			addTest(new CursorTest("test_construction", mainReferance));
			addTest(new CursorTest("test_moving_mouse_off_board_makes_cursor_invisible", mainReferance));
			addTest(new CursorTest("test_moving_mouse_changes_cursor_position_properly", mainReferance));
			addTest(new CursorTest("test_clicking_on_white_piece_twice", mainReferance));
			addTest(new CursorTest("test_legal_move_indicator_state", mainReferance));
			addTest(new CursorTest("test_make_move", mainReferance));
			addTest(new CursorTest("test_mid_selection_interactions", mainReferance));
			addTest(new CursorTest("test_invalid_piece_selection", mainReferance));
		}
	}
}