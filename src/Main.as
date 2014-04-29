package {
	import board.InMemoryBoardData;
	import flash.display.Sprite;
	import flash.events.Event;
	import mouse_control.Cursor;
	import mouse_control.view.*;
	import pieces.ChessPieceFactory;
	import rawdata.RawProductionData;
	
	/** @author Kristian Welsh */
	public class Main extends Sprite {
		private var _rawBoardData:Array = RawProductionData.data;
		private var _boardData:InMemoryBoardData;
		private var _cursor:Cursor;
		
		public function Main():void {
			ChessPieceFactory.CONTAINER = this;
			if (stage)
				startGame();
			else
				addEventListener(Event.ADDED_TO_STAGE, startGame);
		}
		
		protected function startGame(e:Event = null):void {
			addChild(new ChessBoard()); // must add ChessBoard first, or all other objects will be under it.
			_boardData = new InMemoryBoardData(_rawBoardData);
			addCursor();
		}
		
		private function addCursor():void {
			var cursorView:CursorView = new CursorBitmapView();
			new Cursor(_boardData, this, cursorView);
			cursorView.displayOnto(this);
		}
	}
}