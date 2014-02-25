﻿package {
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
		
		private var _main:Main;
		private var _container:DisplayObjectContainer;
		private var _selectedTile:IChessPiece;
		private var _legalMoveIndicators:Array = [];
		private var _hoveredTileX:int;
		private var _hoveredTileY:int;
		private var _hoveredTileIndexY:int;
		private var _hoveredTileIndexX:int;
		private var _stopReselectTimer:Timer = new Timer(1);
		
		public function Cursor(container:DisplayObjectContainer):void {//
			super();
			_container = container;
			_container.addChild(this);
			visible = false;
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
		
		private function tileIndexAt(number:Number):int {//
			return Math.floor(number / TILE_WIDTH);
		}
		
		private function moveFreelyIfNoSelection():void {//
			if (noPieceSelected())
				freelyMoveCursor();
		}
		
		private function noPieceSelected():Boolean {//
			return this.currentFrame == 1;
		}
		
		private function freelyMoveCursor():void {//
			updateCursorVisibility();
			updatePos();
		}
		
		private function updateCursorVisibility():void {//
			this.visible = cursorIsOnBoard() ? true : false;
		}
		
		private function cursorIsOnBoard():Boolean {//
			return _hoveredTileIndexY < BOARD_WIDTH && _hoveredTileIndexX < BOARD_WIDTH && _hoveredTileIndexY >= 0 && _hoveredTileIndexX >= 0;
		}
		
		private function updatePos():void {//
			this.x = _hoveredTileX;
			this.y = _hoveredTileY;
		}
		
		private function selectHoveredWhitePiece(event:MouseEvent):void {
			_main = this.parent as Main;
			
			if (cursorIsOffBoard())
				return;
			if (hoveredChessPieceIsBlack())
				return;
			
			if (noPieceSelected())
				selectHoveredPiece();
			else
				deselectHoveredPiece();
		}
		
		private function cursorIsOffBoard():Boolean {
			return !cursorIsOnBoard();
		}
		
		private function hoveredChessPieceIsBlack():Boolean {
			return _main.chessPieces[_hoveredTileIndexY][_hoveredTileIndexX].black;
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
			_selectedTile = _main.chessPieces[_hoveredTileIndexY][_hoveredTileIndexX];
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
			
			var newPositionPiece:IChessPiece = _main.chessPieces[yIndex][xIndex];
			newPositionPiece.updatePiece(_selectedTile.type, _selectedTile.black);
			newPositionPiece.removeSelfFromStage();
			_main.chessPieces[yIndex][xIndex] = ChessPieceFactory.cloneChessPiece(newPositionPiece, _main);
		}
		
		private function clearOldTile(tile:IChessPiece):void {
			_main.chessPieces[tileIndexAt(tile.y)][tileIndexAt(tile.x)] = ChessPieceFactory.makeChessPiece(0, tile.x, tile.y, true, _main);
			tile.removeSelfFromStage();
		}
		
		/**
		 * delayNextClick() and replenishClickListener() are a workaround for a bug that re-selects chess-pieces after you move them.
		 */
		private function delayNextClick():void {
			_container.removeEventListener(MouseEvent.CLICK, selectHoveredWhitePiece);
			_stopReselectTimer.addEventListener(TimerEvent.TIMER, replenishClickListener);
			_stopReselectTimer.start();
		}
		
		private function replenishClickListener(event:TimerEvent):void {
			_stopReselectTimer.removeEventListener(TimerEvent.TIMER, replenishClickListener);
			_container.addEventListener(MouseEvent.CLICK, selectHoveredWhitePiece);
		}
	}
}