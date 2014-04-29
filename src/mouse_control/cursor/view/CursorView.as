package mouse_control.cursor.view {
	import flash.display.DisplayObjectContainer;
	
	public interface CursorView {
		//see if this interface can be slimmed down, probably introduce fake CursorView for testing Cursor.
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