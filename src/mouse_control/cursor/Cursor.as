package mouse_control.cursor {
	import board.BoardData;
	import board.BoardInfo;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import mouse_control.cursor.view.CursorView;
	import pieces.*;

	// BUG: you can deselect a piece by clicking on another firendly piece
	// TODO: keep a referance to the currently hovered tile then use hoveredTile.tileX instead of the current math based sollution
	public class Cursor {
		private static const BORDER_SIZE:Number = BoardInfo.BORDER_WIDTH;
		private static const TILE_WIDTH:Number = BoardInfo.TILE_WIDTH;
		private static const BOARD_WIDTH:Number = BoardInfo.BOARD_WIDTH;
		private static const BOARD_HEIGHT:Number = BoardInfo.BOARD_HEIGHT;

		private var view:CursorView;
		private var boardData:BoardData;
		private var container:DisplayObjectContainer;
		private var selectedTile:IChessPiece;
		private var legalMoveIndicators:Vector.<LegalMoveIndicator> = new Vector.<LegalMoveIndicator>();

		public function Cursor(boardData:BoardData, container:DisplayObjectContainer, view:CursorView):void {
			super();
			this.boardData = boardData;
			this.container = container;
			this.view = view;
			view.hide();
			addListeners();
		}

		private function addListeners():void {
			container.addEventListener(MouseEvent.MOUSE_MOVE, moveCursorIfNoPieceSelected);
			container.addEventListener(MouseEvent.CLICK, selectHoveredPieceIfPosible);
		}

		private function moveCursorIfNoPieceSelected(event:MouseEvent):void {
			if (!pieceSelected())
				moveCursor();
		}

		private function pieceSelected():Boolean {
			return view.pieceSelected();
		}

		private function moveCursor():void {
			updateCursorVisibility();
			updatePos();
		}

		private function updateCursorVisibility():void {
			cursorIsOnBoard() ? view.show() : view.hide();
		}

		private function cursorIsOnBoard():Boolean {
			return withinXBounds() && withinYBounds()
		}

		private function withinXBounds():Boolean {
			return 0 <= hoveredTileIndexX() && hoveredTileIndexX() < BOARD_WIDTH;
		}

		private function withinYBounds():Boolean {
			return 0 <= hoveredTileIndexY() && hoveredTileIndexY() < BOARD_HEIGHT
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
			view.x = hoveredTileX();
			view.y = hoveredTileY();
		}

		private function selectHoveredPieceIfPosible(event:MouseEvent):void {
			if (canInteractWithHoveredPiece())
				performSelectionAction();
		}

		private function performSelectionAction():void {
			pieceSelected() ?  deselectSelectedPiece() : selectHoveredPiece();
		}

		private function canInteractWithHoveredPiece():Boolean {
			return canInteractWithPiece(hoveredChessPiece())
		}

		private function canInteractWithPiece(piece:IChessPiece):Boolean {
			return cursorIsOnBoard() && isWhite(piece)
		}

		private function isWhite(chessPiece:IChessPiece):Boolean {
			return chessPiece.colour == ChessPieceColour.WHITE;
		}

		private function hoveredChessPiece():IChessPiece {
			return boardData.getChessPieceAt(hoveredTileIndexX(), hoveredTileIndexY());
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
			view.setSelected();
		}

		private function deselectSelectedPiece():void {
			deselectTile();
			removeLegalMoveIndicators();
		}

		private function deselectTile():void {
			selectedTile = null;
			view.setNotSelected();
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

		//TODO: wat iz dis? clean plz
		private function updateNewTile(xIndex:uint, yIndex:uint):void {
			var clickedTile:IChessPiece = boardData.getChessPieceAt(xIndex, yIndex);
			clearTile(selectedTile);
			clickedTile.removeSelfFromParent();
			var newPiece:IChessPiece = ChessPieceFactory.makeChessPiece(selectedTile.type, new Point(xIndex, yIndex), selectedTile.colour, boardData);
			boardData.addPieceToBoard(newPiece);
		}

		private function clearTile(tile:IChessPiece):void {
			var newPiece:IChessPiece = ChessPieceFactory.makeChessPiece(ChessPieceTypes.NULL, new Point(tile.tileX, tile.tileY), ChessPieceColour.NONE, boardData);
			boardData.addPieceToBoard(newPiece);
			tile.removeSelfFromParent();
		}

		// delayNextClick() is a workaround for a bug that re-selects chess-pieces after you move them.
		private function delayNextClick():void {
			container.removeEventListener(MouseEvent.CLICK, selectHoveredPieceIfPosible);
			Util.delayCall(1, function() {
					container.addEventListener(MouseEvent.CLICK, selectHoveredPieceIfPosible);
				});
		}
	}
}