package mouse_control.view {
	import flash.display.DisplayObjectContainer;
	
	public interface CursorView {
		function displayOnto(container:DisplayObjectContainer):void;
		function pieceSelected():Boolean;
		function setSelected():void;
		function setNotSelected():void;
		function set x(value:Number):void;
		function set y(value:Number):void;
		function get x():Number;
		function get y():Number;
		function show():void;
		function hide():void;
		function get visible():Boolean;
	}
}