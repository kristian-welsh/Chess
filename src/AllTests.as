package  {
	import asunit.framework.TestSuite;
	

	public class AllTests extends TestSuite {
		public function AllTests() {
			addTest(new CursorTest("test_construction"));
			addTest(new CursorTest("test_mouse_move"));
		}
	}
}