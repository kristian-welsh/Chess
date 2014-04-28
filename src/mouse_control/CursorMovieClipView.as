package mouse_control {
	import flash.display.DisplayObjectContainer;

	public class CursorMovieClipView implements CursorView {
		private var graphics:CursorGraphics;
		
		public function CursorMovieClipView(graphics:CursorGraphics) {
			this.graphics = graphics;
		}
		
		public function displayOnto(container:DisplayObjectContainer):void {
			container.addChild(graphics);
		}
		
		public function pieceSelected():Boolean {
			return graphics.currentFrame == 2;
		}
		
		public function setSelected():void {
			graphics.gotoAndStop(2);
		}
		
		public function setNotSelected():void {
			graphics.gotoAndStop(1);
		}
		
		public function set x(value:Number):void {
			graphics.x = value;
		}
		
		public function set y(value:Number):void {
			graphics.y = value;
		}
		
		public function get x():Number {
			return graphics.x;
		}
		
		public function get y():Number {
			return graphics.y;
		}
		
		public function show():void {
			graphics.visible = true;
		}
		
		public function hide():void {
			graphics.visible = false;
		}
		
		public function get visible():Boolean {
			return graphics.visible;
		}
	}
}