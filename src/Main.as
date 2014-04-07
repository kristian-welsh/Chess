package {
	import flash.display.Sprite;
	import flash.events.Event;
	import pieces.ChessPieceFactory;
	import pieces.IChessPiece;
	
	public class Main extends Sprite {
		static public const BOARD_WIDTH:uint = 8;
		static public const BOARD_HEIGHT:uint = 8;
		static public const TILE_WIDTH:Number = 36;
		static public const BORDER_WIDTH:Number = 12;
		
		protected var _rawBoardData:Array = RawProductionData.data;
		protected var _boardData:InMemoryBoardData;
		private var _cursor:Cursor;
		
		public function Main():void {
			ChessPieceFactory.MAIN = this;
			if (stage)
				startGame();
			else
				addEventListener(Event.ADDED_TO_STAGE, startGame);
		}
		
		protected function startGame(e:Event = null):void {
			addChild(new ChessBoard()); // must add ChessBoard first, or all other objects will be under it.
			loadBoardData();
			_cursor = new Cursor(_boardData, this);
		}
		
		protected function loadBoardData():void {
			_boardData = new InMemoryBoardData(_rawBoardData);
			_boardData.organizeRawChessData();
		}
	}
}