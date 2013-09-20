/*
	 FEATURES TO IMPLIMENT:

	 Must:
	 CHECK
	 CHECKMATE
	 2P - HUMAN BLACK PLAYER

	 Should:
	 CASTLING
	 EN PASSANT (PAWN TAKING FIRST GO LANDING NEXT TO ENEMY PAWN, ENEMY PAWN IS ALOWED TO TAKE PAWN AS IF HE HAD TAKEN A 1-TILE MOVE)
	 PAWN PROMOTION PIECE SELECTION
	 GAME TIMER
	 KEYBOARD CONTROLS

	 Could:
	 BLACK AI (A*)
	 AUTOMATED GAME RECORDING (example line: T1: Rh5xe5, Qc7xe5)
	 STALEMATE DETECTION
	 CHESS BASED MINIGAMES
	 CHESS GAME RULE VARIANTS

	 Would:
	 ONLINE MULTIPLAYER
	 MAKE 3D CHESS GRAPHICS
	 BLACK AI (board state best move lookup (but since chess isnt "solved" you van only do this some of the time, otherwise use A*)


	 ERRORS TO WORK ON:
	 I AM NOT EATING CAKE RIGHT NOW

	 THINGS TO OPTIMISE:
	 PIECE MOVEMENT FUNCTIONS


	 NOTES:
	 I NEED TO START USING ASUNIT UNIT TESTS

 */
package {
	import ChessPiece;
	import flash.display.Sprite;
	
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
		/*private var _boardData:Array=[
		[p00,p00,p00,p00,p12,p00,p00,p00],
		[p00,p00,p00,p00,p00,p00,p00,p00],
		[p00,p00,p00,p05,p00,p00,p00,p00],
		[p00,p00,p00,p00,p00,p00,p00,p00],
		[p00,p00,p00,p00,p00,p00,p04,p00],
		[p00,p00,p00,p00,p00,p00,p00,p00],
		[p00,p00,p00,p00,p00,p00,p00,p00],
		[p00,p00,p00,p00,p00,p00,p00,p00]];*/
		
		public function Main():void {
			addChild(new ChessBoard());
			addPieces();
			addCursor();
		}
		
		private function addPieces() {
			for (var i:int = 0; i < boardData.length; i++)
				addRowOfPieces(i);
		}
		
		private function addRowOfPieces(i:int):void {
			_chessPieces[i] = [];
			for (var j:int = 0; j < boardData[i].length; j++)
				addPiece(i, j);
		}
		
		private function addPiece(i:int, j:int):void {
			var curPiece:ChessPiece = new ChessPiece(tilePos(j),tilePos(i), boardData[i][j][0], boardData[i][j][1], this);
			addChild(curPiece);
			_chessPieces[i].push(curPiece);
		}
		
		private function tilePos(tileIndex:int):Number {
			return tileIndex * TILE_WIDTH + BORDER_WIDTH;
		}
		
		private function addCursor() {
			cursor = new Cursor(this);
		}
		
		public function get boardData():Array {
			return _boardData;
		}
	}
}