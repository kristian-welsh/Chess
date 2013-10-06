package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	import pieces.ChessPiece;
	import pieces.ChessPieceFactory;
	import pieces.IChessPiece;
	
	// BUG: you can deselect a piece by clicking on another firendly piece
	public class Cursor extends MovieClip {
		private static const BORDER_SIZE:Number = Main.BORDER_WIDTH;
		private static const TILE_WIDTH:Number = Main.TILE_WIDTH;
		static private const BOARD_WIDTH:Number = 8;
		
		private var _main:Main;
		private var _container:DisplayObjectContainer;
		private var _selectedTile:IChessPiece;
		private var _legalMoveIndicators:Array = [];
		private var _hoveredTileX:int;
		private var _hoveredTileY:int;
		private var _hoveredTileIndexY:int;
		private var _hoveredTileIndexX:int;
		
		public function Cursor(container:DisplayObjectContainer):void {
			super();
			_container = container;
			_container.addChild(this);
			visible = false;
			_container.addEventListener(MouseEvent.MOUSE_MOVE, moveCursor);
			_container.addEventListener(MouseEvent.CLICK, selectHoveredWhitePiece);
		}
		
		public function moveCursor(event:MouseEvent):void {
			updatePositionVariables();
			moveFreelyIfNoSelection();
		}
		
		private function updatePositionVariables():void {
			_hoveredTileIndexX = tileIndexAt(_container.mouseX - BORDER_SIZE);
			_hoveredTileIndexY = tileIndexAt(_container.mouseY - BORDER_SIZE);
			_hoveredTileX = _hoveredTileIndexX * TILE_WIDTH + BORDER_SIZE;
			_hoveredTileY = _hoveredTileIndexY * TILE_WIDTH + BORDER_SIZE;
		}
		
		private function tileIndexAt(number:Number):int {
			return Math.floor(number / TILE_WIDTH);
		}
		
		private function moveFreelyIfNoSelection():void {
			if (noPieceSelected())
				freelyMoveCursor();
		}
		
		private function freelyMoveCursor():void {
			updateCursorVisibility();
			updatePos();
		}
		
		private function updateCursorVisibility():void {
			this.visible = cursorIsOnBoard() ? true : false;
		}
		
		private function cursorIsOnBoard():Boolean {
			return _hoveredTileIndexY < BOARD_WIDTH && _hoveredTileIndexX < BOARD_WIDTH && _hoveredTileIndexY >= 0 && _hoveredTileIndexX >= 0;
		}
		
		private function updatePos():void {
			this.x = _hoveredTileX;
			this.y = _hoveredTileY;
		}
		
		private function selectHoveredWhitePiece(event:MouseEvent):void {
			_main = this.parent as Main;
			
			if (!cursorIsOnBoard())
				return;
			if (!hoveredChessPieceIsWhite())
				return;
			
			if (noPieceSelected())
				selectHoveredPiece();
			else
				deselectHoveredPiece();
		}
		
		private function hoveredChessPieceIsWhite():Boolean {
			return !_main._chessPieces[_hoveredTileIndexY][_hoveredTileIndexX]._black;
		}
		
		private function noPieceSelected():Boolean {
			return this.currentFrame == 1;
		}
		
		private function selectHoveredPiece():void {
			selectHoveredTile();
			var legalMoves:Array = _selectedTile.legalMoves();
			for (var i:uint = 0; i < legalMoves.length; i++) {
				_legalMoveIndicators[i] = new validMove();
				_legalMoveIndicators[i].x = legalMoves[i].x * 36 + BORDER_SIZE;
				_legalMoveIndicators[i].y = legalMoves[i].y * 36 + BORDER_SIZE;
				_legalMoveIndicators[i].addEventListener(MouseEvent.CLICK, makeMove);
				_main.addChild(_legalMoveIndicators[i]);
			}
		}
		
		private function selectHoveredTile():void {
			_selectedTile = _main._chessPieces[_hoveredTileIndexY][_hoveredTileIndexX];
			this.gotoAndStop(2);
		}
		
		private function deselectHoveredPiece():void {
			deselectTile();
			for (var i:uint = 0; i < _legalMoveIndicators.length; i++)
				_main.removeChild(_legalMoveIndicators[i]);
			_legalMoveIndicators = [];
		}
		
		private function deselectTile():void {
			_selectedTile = null;
			this.gotoAndStop(1);
		}
		
		private function makeMove(event:MouseEvent):void {
			removeLegalMoveIndicators();
			updateNewTile(tileIndexAt(event.target.x), tileIndexAt(event.target.y));
			deselectTile();
			updatePos();
			delayNextClick();
		}
		
		private function removeLegalMoveIndicators():void {
			for (var i:int = 0; i < _legalMoveIndicators.length; i++)
				_legalMoveIndicators[i].parent.removeChild(_legalMoveIndicators[i]);
			_legalMoveIndicators = [];
		}
		
		private function updateNewTile(xIndex:uint, yIndex:uint):void {
			clearOldTile(_selectedTile);
			_main.boardData[yIndex][xIndex] = [_selectedTile.type, _selectedTile.black];
			
			var newPositionPiece:IChessPiece = _main._chessPieces[yIndex][xIndex];
			newPositionPiece.updatePiece(_selectedTile.type, _selectedTile.black);
			newPositionPiece.removeSelfFromStage();
			_main._chessPieces[yIndex][xIndex] = ChessPieceFactory.cloneChessPiece(newPositionPiece, _main);
		}
		
		private function clearOldTile(tile:IChessPiece):void {
			var xIndex:uint = tileIndexAt(tile.x);
			var yIndex:uint = tileIndexAt(tile.y);
			_main._chessPieces[yIndex][xIndex] = ChessPieceFactory.makeChessPiece(0, tile.x, tile.y, true, _main);
			_main.boardData[yIndex][xIndex] = [0, 1];
			tile.removeSelfFromStage();
		}
		
		/**
		 * Timers are a workaround for a glitch(?) that re-selects chess-pieces after you move them.
		 */
		private function delayNextClick():void {
			_container.removeEventListener(MouseEvent.CLICK, selectHoveredWhitePiece);
			var tets:Timer = new Timer(1);
			tets.addEventListener(TimerEvent.TIMER, replenishClickListener);
			tets.start();
		}
		
		private function replenishClickListener(event:TimerEvent):void {
			freelyMoveCursor();
			_container.addEventListener(MouseEvent.CLICK, selectHoveredWhitePiece);
		}
	}
}