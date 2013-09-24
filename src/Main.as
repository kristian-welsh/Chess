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
	import pieces.ChessPiece;
	import pieces.ChessPieceFactory;
	import flash.display.Sprite;
	import pieces.IChessPiece;
	
	public class Main extends Sprite {
		static public const TILE_WIDTH:Number = 36;
		static public const BORDER_WIDTH:Number = 12;
		
		private var cursor:Cursor;
		
		public var _chessPieces:Array = [];
		private var p00 = [0, 1];
		private var p01 = [1, 0];
		private var p02 = [2, 0];
		private var p03 = [3, 0];
		private var p04 = [4, 0];
		private var p05 = [5, 0];
		private var p06 = [6, 0];
		private var p07 = [1, 1];
		private var p08 = [2, 1];
		private var p09 = [3, 1];
		private var p10 = [4, 1];
		private var p11 = [5, 1];
		private var p12 = [6, 1];
		
		private var _boardData:Array = [
		[p08, p09, p10, p11, p12, p10, p09, p08],
		[p07, p07, p07, p07, p07, p07, p07, p07],
		[p00, p00, p00, p00, p00, p00, p00, p00],
		[p00, p00, p00, p00, p00, p00, p00, p00],
		[p00, p00, p00, p00, p00, p00, p00, p00],
		[p00, p00, p00, p00, p00, p00, p00, p00],
		[p01, p01, p01, p01, p01, p01, p01, p01],
		[p02, p03, p04, p05, p06, p04, p03, p02]];
		
		public function Main():void {
			addChild(new ChessBoard());
			addPieces();
			addCursor();
		}
		
		private function addPieces():void {
			for (var i:int = 0; i < boardData.length; i++)
				addRowOfPieces(i);
		}
		
		private function addRowOfPieces(i:int):void {
			_chessPieces[i] = [];
			for (var j:int = 0; j < boardData[i].length; j++)
				addPiece(i, j);
		}
		
		private function addPiece(i:int, j:int):void {
			var curPiece:IChessPiece = ChessPieceFactory.makeChessPiece(tilePos(j), tilePos(i), boardData[i][j][0], boardData[i][j][1], this);
			_chessPieces[i].push(curPiece);
		}
		
		private function tilePos(tileIndex:int):Number {
			return tileIndex * TILE_WIDTH + BORDER_WIDTH;
		}
		
		private function addCursor():void {
			cursor = new Cursor(this);
		}
		
		public function get boardData():Array {
			return _boardData;
		}
	}
}