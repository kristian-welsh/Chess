/**
 * FEATURES TO IMPLIMENT:
 *
 * Must:
 * CHECK
 * CHECKMATE
 * 2P - HUMAN BLACK PLAYER
 *
 * Should:
 * CASTLING
 * EN PASSANT (PAWN TAKING FIRST GO LANDING NEXT TO ENEMY PAWN, ENEMY PAWN IS ALOWED TO TAKE PAWN AS IF HE HAD TAKEN A 1-TILE MOVE)
 * PAWN PROMOTION PIECE SELECTION
 * GAME TIMER
 * KEYBOARD CONTROL
 *
 * Could:
 * BLACK AI (A*, heuristics, neural networks)
 * AUTOMATED GAME RECORDING (example line: T1: Rh5xe5, Qc7xe5)
 * STALEMATE DETECTION
 * CHESS BASED MINIGAMES
 * CHESS GAME RULE VARIANTS
 *
 * Would:
 * ONLINE MULTIPLAYER
 * MAKE 3D CHESS GRAPHICS
 * BLACK AI (board state best move lookup (but since chess isnt "solved" you van only do this some of the time, otherwise use A*)
 *
 * ERRORS TO WORK ON:
 * FIND A BETTER WORK AROUND FOR SINGLE CLICK RE-SELECTION IN CURSOR CLASS
 *
 * THINGS TO OPTIMISE:
 * PIECE MOVEMENT FUNCTIONS
 * Extract the board data into an object
 *
 * NOTES:
 * I NEED TO START USING UNIT TESTS
 */
package {
	import asunit.textui.TestRunner;
	import flash.display.Sprite;
	import flash.events.Event;
	import pieces.ChessPieceFactory;
	import pieces.IChessPiece;
	import test.AllTests;
	import test.FakeSprite;
	
	public class Main extends FakeSprite implements BoardData {
		static public const BOARD_WIDTH:uint = 8;
		static public const BOARD_HEIGHT:uint = 8;
		static public const TILE_WIDTH:Number = 36;
		static public const BORDER_WIDTH:Number = 12;
		
		private var cursor:Cursor;
		
		protected var p00:Array = [0, true];
		protected var p01:Array = [1, false];
		private var p02:Array = [2, false];
		private var p03:Array = [3, false];
		private var p04:Array = [4, false];
		private var p05:Array = [5, false];
		private var p06:Array = [6, false];
		protected var p07:Array = [1, true];
		private var p08:Array = [2, true];
		private var p09:Array = [3, true];
		private var p10:Array = [4, true];
		private var p11:Array = [5, true];
		private var p12:Array = [6, true]
		
		protected var _rawBoardData:Array = [
		[p08, p09, p10, p11, p12, p10, p09, p08],
		[p07, p07, p07, p07, p07, p07, p07, p07],
		[p00, p00, p00, p00, p00, p00, p00, p00],
		[p00, p00, p00, p00, p00, p00, p00, p00],
		[p00, p00, p00, p00, p00, p00, p00, p00],
		[p00, p00, p00, p00, p00, p00, p00, p00],
		[p01, p01, p01, p01, p01, p01, p01, p01],
		[p02, p03, p04, p05, p06, p04, p03, p02]];
		private var _chessPieces:Array = [];
		private var _boardData:InMemoryBoardData;
		
		public function Main():void {
			ChessPieceFactory.MAIN = this;
			if(stage)
				startGame();
			else
				addEventListener(Event.ADDED_TO_STAGE, startGame);
		}
		
		protected function startGame(e:Event = null):void {
			addChild(new ChessBoard());
			organizeChessData();
			cursor = new Cursor(this, this);
		}
		
		protected function organizeChessData():void {
			_boardData = new InMemoryBoardData(_chessPieces);
			for (var i:int = 0; i < _rawBoardData.length; i++)
				addRowOfPieces(i);
		}
		
		private function addRowOfPieces(i:int):void {
			_boardData.data[i] = [];
			for (var j:int = 0; j < _rawBoardData[i].length; j++)
				addPiece(i, j);
		}
		
		private function addPiece(i:int, j:int):void {
			//validateTileIndexes(i, j);
			var type:uint = _rawBoardData[i][j][0];
			var black:Boolean = _rawBoardData[i][j][1];
			var x:Number = tilePos(j);
			var y:Number = tilePos(i);
			_boardData.data[i].push(ChessPieceFactory.makeChessPiece(type, x, y, black));
		}
		
		private function tilePos(tileIndex:int):Number {
			return tileIndex * TILE_WIDTH + BORDER_WIDTH;
		}
		
		public function get chessPieces():Array {
			return _chessPieces;
		}
		
		public function getChessPieceAt(y:uint, x:uint):IChessPiece {
			return _boardData.getChessPieceAt(y, x);
		}
		
		public function setChessPieceAt(y:uint, x:uint, newChessPiece:IChessPiece):void {
			_boardData.setChessPieceAt(y, x, newChessPiece);
		}
	}
}