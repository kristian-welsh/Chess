package test {
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class FakeSprite extends Sprite {
		// mouseX and mouseY in DisplayObject are read only, workaround for testing.
		private var mousePos:Point = new Point();
		
		private var fakeEnabled:Boolean = false;
		
		public function setMousePosition(x:Number, y:Number):void {
			mouseX = x;
			mouseY = y;
		}
		
		public function set mouseX(value:Number):void {
			mousePos.x = value;
		}
		
		public override function get mouseX():Number {
			return fakeEnabled? mousePos.x : super.mouseX;
		}
		
		public function set mouseY(value:Number):void {
			mousePos.y = value;
		}
		
		public override function get mouseY():Number {
			return fakeEnabled? mousePos.y : super.mouseY;
		}
		
		public function enableFakeMousePosition():void {
			fakeEnabled = true;
		}
	}
}