package mouse_control.view {
	import flash.display.*;

	public class CursorBitmapView implements CursorView {
		private static const CURSOR_WIDTH:Number = 38;
		private static const CURSOR_HEIGHT:Number = CURSOR_WIDTH;
		
		[Embed(source="../../../assets/cursor-unselected.png")]
		private static const UnselectedImage:Class;
		
		[Embed(source="../../../assets/cursor-selected.png")]
		private static const SelectedImage:Class;
		
		private var selected:Boolean;
		private var bitmap:Bitmap;
		private var bitmapData:BitmapData;
		
		public function CursorBitmapView() {
			bitmapData = new BitmapData(CURSOR_WIDTH, CURSOR_HEIGHT, true, 0);
			bitmap = new Bitmap(bitmapData);
			setNotSelected();
		}
		
		public function displayOnto(container:DisplayObjectContainer):void {
			container.addChild(bitmap);
		}
		
		public function pieceSelected():Boolean {
			return selected;
		}
		
		public function setSelected():void {
			selected = true;
			bitmapData.draw(new SelectedImage());
		}
		
		public function setNotSelected():void {
			selected = false;
			bitmapData.draw(new UnselectedImage());
		}
		
		public function set x(value:Number):void {
			bitmap.x = value;
		}
		
		public function set y(value:Number):void {
			bitmap.y = value;
		}
		
		public function get x():Number {
			return bitmap.x;
		}
		
		public function get y():Number {
			return bitmap.y;
		}
		
		public function show():void {
			bitmap.visible = true;
		}
		
		public function hide():void {
			bitmap.visible = false
		}
		
		public function get visible():Boolean {
			return bitmap.visible;
		}
	}
}