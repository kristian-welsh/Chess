package {
	import board.BoardData;
	import board.BoardInfo;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import pieces.*;
	
	// BUG: you can deselect a piece by clicking on another firendly piece
	// TODO: keep a referance to the currently hovered tile then use hoveredTile.tileX instead of the current math based sollution
	public class Cursor extends MovieClip {
		private static const BORDER_SIZE:Number = BoardInfo.BORDER_WIDTH;
		private static const TILE_WIDTH:Number = BoardInfo.TILE_WIDTH;
		private static const BOARD_WIDTH:Number = BoardInfo.BOARD_WIDTH;
		private static const BOARD_HEIGHT:Number = BoardInfo.BOARD_HEIGHT;
		
		private var boardData:BoardData;
		private var container:DisplayObjectContainer;
		private var selectedTile:IChessPiece;
		private var legalMoveIndicators:Vector.<LegalMoveIndicator> = new Vector.<LegalMoveIndicator>();
		
		public function Cursor(boardData:BoardData, container:DisplayObjectContainer):void {
			super();
			this.boardData = boardData;
			this.container = container;
			visible = false;
			addListeners();
		}
		
		private function addListeners():void {
			container.addEventListener(MouseEvent.MOUSE_MOVE, moveCursorIfNoPieceSelected);
			container.addEventListener(MouseEvent.CLICK, selectHoveredValidPiece);
		}
		
		private function moveCursorIfNoPieceSelected(event:MouseEvent):void {
			if (!pieceSelected())
				moveCursor();
		}
		
		private function pieceSelected():Boolean {
			return this.currentFrame != 1;
		}
		
		private function moveCursor():void {
			updateCursorVisibility();
			updatePos();
		}
		
		private function updateCursorVisibility():void {
			this.visible = cursorIsOnBoard() ? true : false;
		}
		
		private function cursorIsOnBoard():Boolean {
			if (0 > hoveredTileIndexX() || hoveredTileIndexX() >= BOARD_WIDTH)
				return false;
			if (0 > hoveredTileIndexY() || hoveredTileIndexY() >= BOARD_HEIGHT)
				return false;
			return true;
		}
		
		private function hoveredTileIndexX():Number {
			return tileIndexAt(container.mouseX - BORDER_SIZE);
		}
		
		private function hoveredTileIndexY():Number {
			return tileIndexAt(container.mouseY - BORDER_SIZE);
		}
		
		private function hoveredTileX():Number {
			return hoveredTileIndexX() * TILE_WIDTH + BORDER_SIZE;
		}
		
		private function hoveredTileY():Number {
			return hoveredTileIndexY() * TILE_WIDTH + BORDER_SIZE;
		}
		
		private function tileIndexAt(number:Number):int {
			return Math.floor(number / TILE_WIDTH);
		}
		
		private function updatePos():void {
			this.x = hoveredTileX();
			this.y = hoveredTileY();
		}
		
		private function selectHoveredValidPiece(event:MouseEvent):void {
			if (canInteractWithTile()) {
				if (pieceSelected())
					deselectSelectedPiece();
				else
					selectHoveredPiece();
			}
		}
		
		private function canInteractWithTile():Boolean {
			if (!cursorIsOnBoard())
				return false;
			if (hoveredChessPieceIsBlack())
				return false;
			return true;
		}
		
		private function hoveredChessPieceIsBlack():Boolean {
			return boardData.getChessPieceAt(hoveredTileIndexX(), hoveredTileIndexY()).black;
		}
		
		private function selectHoveredPiece():void {
			selectHoveredTile();
			showLegalMoves();
		}
		
		private function showLegalMoves():void {
			for (var i:uint = 0; i < legalMoves().length; i++)
				showLegalMove(legalMoves()[i] as Point);
		}
		
		private function legalMoves():Array {
			return selectedTile.legalMoves();
		}
		
		private function showLegalMove(move:Point):void {
			var currentLegalMove:LegalMoveIndicator = new LegalMoveIndicator();
			legalMoveIndicators.push(currentLegalMove);
			positionMoveIndicator(currentLegalMove, move);
			enableMoveIndicator(currentLegalMove);
			displayMoveIndicator(currentLegalMove);
		}
		
		private function positionMoveIndicator(indicator:LegalMoveIndicator, tilePosition:Point):void {
			indicator.x = tilePosition.x * TILE_WIDTH + BORDER_SIZE;
			indicator.y = tilePosition.y * TILE_WIDTH + BORDER_SIZE;
		}
		
		private function enableMoveIndicator(indicator:LegalMoveIndicator):void {
			indicator.addEventListener(MouseEvent.CLICK, makeMove);
		}
		
		private function displayMoveIndicator(indicator:LegalMoveIndicator):void {
			container.addChild(indicator);
		}
		
		private function selectHoveredTile():void {
			selectedTile = boardData.getChessPieceAt(hoveredTileIndexX(), hoveredTileIndexY());
			this.gotoAndStop(2);
		}
		
		private function deselectSelectedPiece():void {
			deselectTile();
			removeLegalMoveIndicators();
		}
		
		private function deselectTile():void {
			selectedTile = null;
			this.gotoAndStop(1);
			updatePos();
		}
		
		private function removeLegalMoveIndicators():void {
			for (var i:int = 0; i < legalMoveIndicators.length; i++)
				container.removeChild(legalMoveIndicators[i]);
			legalMoveIndicators = new Vector.<LegalMoveIndicator>();
		}
		
		private function makeMove(event:MouseEvent):void {
			updateNewTile(tileIndexAt(event.target.x), tileIndexAt(event.target.y));
			deselectSelectedPiece();
			delayNextClick();
		}
		
		private function updateNewTile(xIndex:uint, yIndex:uint):void {
			clearOldTile(selectedTile);
			var movedToPiece:IChessPiece = boardData.getChessPieceAt(xIndex, yIndex);
			movedToPiece.removeSelfFromStage();
			var newPiece:IChessPiece = ChessPieceFactory.makeChessPiece(selectedTile.type, new Point(movedToPiece.tileX, movedToPiece.tileY), selectedTile.black, boardData);
			boardData.setChessPieceAt(xIndex, yIndex, newPiece);
		}
		
		private function clearOldTile(tile:IChessPiece):void {
			var newPiece:IChessPiece = ChessPieceFactory.makeChessPiece(ChessPieceTypes.NULL, new Point(tile.tileX, tile.tileY), true, boardData);
			boardData.setChessPieceAt(tile.tileX, tile.tileY, newPiece);
			tile.removeSelfFromStage();
		}
		
		// delayNextClick() is a workaround for a bug that re-selects chess-pieces after you move them.
		private function delayNextClick():void {
			container.removeEventListener(MouseEvent.CLICK, selectHoveredValidPiece);
			var replenishClickListener:Function = function() {
				container.addEventListener(MouseEvent.CLICK, selectHoveredValidPiece);
			}
			Util.delayCall(replenishClickListener, 1);
		}
	}
}