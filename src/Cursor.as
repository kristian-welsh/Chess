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
		private static const BOARD_WIDTH:Number = 8;
		
		private var _boardData:BoardData;
		private var _container:DisplayObjectContainer;
		private var _selectedTile:IChessPiece;
		private var _legalMoveIndicators:Array = [];
		private var _hoveredTileX:int;
		private var _hoveredTileY:int;
		private var _hoveredTileIndexY:int;
		private var _hoveredTileIndexX:int;
		private var _stopReselectTimer:Timer = new Timer(1, 1);
		
		public function Cursor(boardData:BoardData, container:DisplayObjectContainer):void {
			super();
			_boardData = boardData;
			_container = container;
			_container.addChild(this);
			visible = false;
			addListeners();
		}
		
		private function addListeners():void {
			_container.addEventListener(MouseEvent.MOUSE_MOVE, moveCursor);
			_container.addEventListener(MouseEvent.CLICK, selectHoveredWhitePiece);
		}
		
		private function moveCursor(event:MouseEvent):void {
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
			if (pieceSelected())
				return
			freelyMoveCursor();
		}
		
		private function pieceSelected():Boolean {
			return this.currentFrame != 1;
		}
		
		private function freelyMoveCursor():void {
			updateCursorVisibility();
			updatePos();
		}
		
		private function updateCursorVisibility():void {
			this.visible = cursorIsOnBoard() ? true : false;
		}
		
		private function cursorIsOnBoard():Boolean {
			if (_hoveredTileIndexX < 0) return false;
			if (_hoveredTileIndexY < 0) return false;
			if (_hoveredTileIndexX >= BOARD_WIDTH) return false;
			if (_hoveredTileIndexY >= BOARD_WIDTH) return false;
			return true;
		}
		
		private function updatePos():void {
			this.x = _hoveredTileX;
			this.y = _hoveredTileY;
		}
		
		private function selectHoveredWhitePiece(event:MouseEvent):void {
			if (!canInteractWithTile())
				return;
			if (pieceSelected())
				deselectSelectedPiece();
			else
				selectHoveredPiece();
		}
		
		private function canInteractWithTile():Boolean {
			if (!cursorIsOnBoard())
				return false;
			if (hoveredChessPieceIsBlack())
				return false;
			return true;
		}
		
		private function hoveredChessPieceIsBlack():Boolean {
			return _boardData.getChessPieceAt(_hoveredTileIndexY, _hoveredTileIndexX).black;
		}
		
		private function selectHoveredPiece():void {
			selectHoveredTile();
			showLegalMoves();
		}
		
		private function showLegalMoves():void {
			for (var i:uint = 0; i < legalMoves().length; i++)
				showLegalMove(i);
		}
		
		private function legalMoves():Array {
			return _selectedTile.legalMoves();
		}
		
		private function showLegalMove(index:uint):void {
			_legalMoveIndicators[index] = new validMove();
			positionLegalMove(index);
			enableLegalMove(index);
			displayLegalMove(index);
		}
		
		private function positionLegalMove(index:uint):void {
			_legalMoveIndicators[index].x = legalMoves()[index].x * TILE_WIDTH + BORDER_SIZE;
			_legalMoveIndicators[index].y = legalMoves()[index].y * TILE_WIDTH + BORDER_SIZE;
		}
		
		private function enableLegalMove(index:uint):void {
			_legalMoveIndicators[index].addEventListener(MouseEvent.CLICK, makeMove);
		}
		
		private function displayLegalMove(index:uint):void {
			_container.addChild(_legalMoveIndicators[index]);
		}
		
		private function selectHoveredTile():void {
			_selectedTile = _boardData.getChessPieceAt(_hoveredTileIndexY, _hoveredTileIndexX);
			this.gotoAndStop(2);
		}
		
		private function deselectSelectedPiece():void {
			deselectTile();
			removeLegalMoveIndicators();
		}
		
		private function deselectTile():void {
			_selectedTile = null;
			this.gotoAndStop(1);
			updatePos();
		}
		
		private function removeLegalMoveIndicators():void {
			for (var i:int = 0; i < _legalMoveIndicators.length; i++)
				_container.removeChild(_legalMoveIndicators[i]);
			_legalMoveIndicators = [];
		}
		
		private function makeMove(event:MouseEvent):void {
			updateNewTile(tileIndexAt(event.target.x), tileIndexAt(event.target.y));
			deselectSelectedPiece();
			delayNextClick();
		}
		
		private function updateNewTile(xIndex:uint, yIndex:uint):void {
			clearOldTile(_selectedTile);
			var newPositionPiece:IChessPiece = _boardData.getChessPieceAt(yIndex, xIndex);
			newPositionPiece.updatePiece(_selectedTile.type, _selectedTile.black);
			newPositionPiece.removeSelfFromStage();
			_boardData.setChessPieceAt(yIndex, xIndex, ChessPieceFactory.cloneChessPiece(newPositionPiece));
		}
		
		private function clearOldTile(tile:IChessPiece):void {
			_boardData.setChessPieceAt(tileIndexAt(tile.y), tileIndexAt(tile.x), ChessPieceFactory.makeChessPiece(0, tile.x, tile.y, true));
			tile.removeSelfFromStage();
		}
		
		// delayNextClick() and replenishClickListener() are a workaround for a bug that re-selects chess-pieces after you move them.
		private function delayNextClick():void {
			_container.removeEventListener(MouseEvent.CLICK, selectHoveredWhitePiece);
			_stopReselectTimer.addEventListener(TimerEvent.TIMER_COMPLETE, replenishClickListener);
			_stopReselectTimer.start();
		}
		
		private function replenishClickListener(event:TimerEvent):void {
			_stopReselectTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, replenishClickListener);
			_container.addEventListener(MouseEvent.CLICK, selectHoveredWhitePiece);
		}
		
		//////////////////////
		/**
		 * WARNING: DO NOT USE, this variable only exposed for ease of testing, delete as soon as possible.
		 */
		public function get legalMoveIndicators():Array {
			return _legalMoveIndicators;
		}
		//////////////////////
	}
}