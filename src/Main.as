﻿/**
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
		
		private var _chessPieces:Array = [];
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
		
		protected var _boardData:Array = [
		[p08, p09, p10, p11, p12, p10, p09, p08],
		[p07, p07, p07, p07, p07, p07, p07, p07],
		[p00, p00, p00, p00, p00, p00, p00, p00],
		[p00, p00, p00, p00, p00, p00, p00, p00],
		[p00, p00, p00, p00, p00, p00, p00, p00],
		[p00, p00, p00, p00, p00, p00, p00, p00],
		[p01, p01, p01, p01, p01, p01, p01, p01],
		[p02, p03, p04, p05, p06, p04, p03, p02]];
		
		public function Main():void {
			ChessPieceFactory.MAIN = this;
			if(stage)
				startGame();
			else
				addEventListener(Event.ADDED_TO_STAGE, startGame);
		}
		
		protected function startGame(e:Event = null):void {
			addChild(new ChessBoard());
			addPieces();
			addCursor();
		}
		
		protected function addPieces():void {
			for (var i:int = 0; i < boardData.length; i++)
				addRowOfPieces(i);
		}
		
		private function addRowOfPieces(i:int):void {
			_chessPieces[i] = [];
			for (var j:int = 0; j < boardData[i].length; j++)
				addPiece(i, j);
		}
		
		private function addPiece(i:int, j:int):void {
			validateTileIndexes(i, j);
			var type:uint = boardData[i][j][0];
			var black:Boolean = boardData[i][j][1];
			var x:Number = tilePos(j);
			var y:Number = tilePos(i);
			_chessPieces[i].push(ChessPieceFactory.makeChessPiece(type, x, y, black));
		}
		
		private function tilePos(tileIndex:int):Number {
			return tileIndex * TILE_WIDTH + BORDER_WIDTH;
		}
		
		private function addCursor():void {
			cursor = new Cursor(this, this);
		}
		
		public function get boardData():Array {
			return _boardData;
		}
		
		public function get chessPieces():Array {
			return _chessPieces;
		}
		
		public function getChessPieceAt(y:uint, x:uint):IChessPiece {
			validateTileIndexes(y, x);
			return _chessPieces[y][x] as IChessPiece;
		}
		
		public function setChessPieceAt(y:uint, x:uint, newChessPiece:IChessPiece):void {
			validateTileIndexes(y, x);
			_chessPieces[y][x] = newChessPiece;
		}
		
		private function validateTileIndexes(y:uint, x:uint):void {
			if (y >= BOARD_HEIGHT || x >= BOARD_WIDTH)
				throwInvalidInputsError(y, x);
		}
		
		private function throwInvalidInputsError(y:uint, x:uint):String {
			throw new Error("y: " + y + ", x: " + x + " are invalid inputs, valid inputs are integers between 0 and BOARD_WIDTH - 1");
		}
	}
}