package test {
	import asunit.framework.TestSuite;
	import pieces.ChessPieceTest;
	
	public class AllTests extends TestSuite {
		public function AllTests() {
			addTest(new CursorTest("test_construction"));
			addTest(new CursorTest("test_moving_mouse_off_board_makes_cursor_invisible"));
			addTest(new CursorTest("test_moving_mouse_changes_cursor_position_properly"));
			addTest(new CursorTest("test_clicking_on_white_piece_twice"));
			addTest(new CursorTest("test_legal_move_indicator_state"));
			addTest(new CursorTest("test_make_move"));
			addTest(new CursorTest("test_mid_selection_interactions"));
			addTest(new CursorTest("test_invalid_piece_selection"));
			addTest(new CursorTest("test_soon_after_movement_select_piece_fails"));
			addTest(new CursorTest("test_second_move_after_while_succeeds"));
			addTest(new ChessPieceTest("characterisation"));
			addTest(new ChessPieceTest("proper_frame_selection"));
			addTest(new ChessPieceTest("constructor_positions_piece_correctly"));
			addTest(new ChessPieceTest("should_return_type_and_colour_correctly_before_input"));
		}
	}
}