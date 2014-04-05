package {
	import flash.display.Sprite;
	import flash.events.Event;
	import pieces.ChessPieceFactory;
	import pieces.IChessPiece;
	
	public class Main extends Sprite implements BoardData {
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
			organizeChessData();
			_cursor = new Cursor(_boardData, this);
		}
		
		protected function organizeChessData():void {
			_boardData = new InMemoryBoardData(_rawBoardData);
			_boardData.organizeRawChessData();
		}
		
		public function getChessPieceAt(y:uint, x:uint):IChessPiece {
			return _boardData.getChessPieceAt(y, x);
		}
		
		public function setChessPieceAt(y:uint, x:uint, newChessPiece:IChessPiece):void {
			_boardData.setChessPieceAt(y, x, newChessPiece);
		}
		
		public function tileExistsAt(y:int, x:int):Boolean {
			return _boardData.tlieExistsAt(y, x);
		}
	}
}