package pieces {
	import board.BoardData;
	import board.BoardInfo;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class ChessPiece extends MovieClip implements IChessPiece {
		protected var _blackFrameNumber:uint;
		private var _colour:String;
		protected var _type:Class;
		protected var _tx:int;
		protected var _ty:int;
		protected var _boardData:BoardData;
		
		public function ChessPiece(tileCoordinates:Point, colour:String, boardData:BoardData):void {
			super();
			this.x = tilePos(tileCoordinates.x);
			this.y = tilePos(tileCoordinates.y);
			_tx = tileCoordinates.x;
			_ty = tileCoordinates.y;
			_boardData = boardData;
			setColour(colour);
		}
		
		private function tilePos(tileIndex:int):Number {
			return tileIndex * BoardInfo.TILE_WIDTH + BoardInfo.BORDER_WIDTH;
		}
		
		public function setColour(colour:String):void {
			this._colour = colour;
			var displayFrame:uint = (colour == ChessPieceColours.BLACK) ? _blackFrameNumber : _blackFrameNumber - 1;
			gotoAndStop(displayFrame);
		}
		
		public function get type():Class {
			return _type
		}
		
		public function get colour():String {
			return _colour;
		}
		
		protected function nonDiagonalMovement(limit:int):Array {
			var returnMe:Array = []
			for (var i:uint = 1; i < limit + 1; i++) {
				if (leftMovement(limit) >= i)
					returnMe.push(new Point(_tx - i, _ty));
				if (upMovement(limit) >= i)
					returnMe.push(new Point(_tx, _ty - i));
				if (rightMovement(limit) >= i)
					returnMe.push(new Point(_tx + i, _ty));
				if (downMovement(limit) >= i)
					returnMe.push(new Point(_tx, _ty + i));
			}
			return returnMe;
		}
		
		protected function diagonalMovement(limit:int):Array {
			var returnMe:Array = []
			for (var i:uint = 1; i < limit + 1; i++) {
				if (upLeftMovement(limit) >= i)
					returnMe.push(new Point(_tx - i, _ty - i));
				if (upRightMovement(limit) >= i)
					returnMe.push(new Point(_tx + i, _ty - i));
				if (downLeftMovement(limit) >= i)
					returnMe.push(new Point(_tx - i, _ty + i));
				if (downRightMovement(limit) >= i)
					returnMe.push(new Point(_tx + i, _ty + i));
			}
			return returnMe;
		}
		
		protected function upMovement(limit:uint):uint {
			return pathLength(limit, 0, -1);
		}
		
		private function downMovement(limit:uint):uint {
			return pathLength(limit, 0, 1);
		}
		
		private function leftMovement(limit:uint):uint {
			return pathLength(limit, -1, 0);
		}
		
		private function rightMovement(limit:uint):uint {
			return pathLength(limit, 1, 0);
		}
		
		private function upLeftMovement(limit:uint):uint {
			return pathLength(limit, -1, -1);
		}
		
		private function upRightMovement(limit:uint):uint {
			return pathLength(limit, 1, -1);
		}
		
		private function downLeftMovement(limit:uint):uint {
			return pathLength(limit, -1, 1);
		}
		
		private function downRightMovement(limit:uint):uint {
			return pathLength(limit, 1, 1);
		}
		
		/**
		 * Inspects each tile in a perfectly diagonal or perfectly straight line to decide how many tiles this piece can move in the specified direction.
		 * @param	xDirection Should be -1 for left, 0 for no x direction, or 1 for right.
		 * @param	yDirection Should be -1 for up, 0 for no y direction, or 1 for down.
		 * @return The number of spaces that can be moved by this peice in that direction,
		 * @example pathLength(3, 1, -1); looks 3 spaces towards the upper-right of the piece's position.
		 */
		protected function pathLength(limit:uint, xDirection:Number, yDirection:Number):uint {
			//TODO: think about refactoring to use moveIsValidAt()
			invalidatePathLengthInputs(xDirection, yDirection);
			for (var i:int = 0; i < limit; i++) {
				var inspectedPosition:Point = new Point(_tx + i * xDirection + xDirection, _ty + i * yDirection + yDirection);
				if (!tileExistsAt(inspectedPosition))
					return i;
				else if (tileIsWhiteAt(inspectedPosition))
					return i;
				else if (tileIsOccupiedAt(inspectedPosition))
					return i + 1;
			}
			return limit;
		}
		
		private function invalidatePathLengthInputs(xDirection:Number, yDirection:Number):void {
			if (xDirection != -1 && xDirection != 0 && xDirection != 1)
				throw new Error("xDirection needs to be either -1, 0, or 1. xDirection was:" + xDirection);
			if (yDirection != -1 && yDirection != 0 && yDirection != 1)
				throw new Error("yDirection needs to be either -1, 0, or 1. yDirection was:" + yDirection);
		}
		
		private function tileExistsAt(point:Point):Boolean {
			return _boardData.tileExistsAt(point.x, point.y);
		}
		
		protected function tileIsWhiteAt(point:Point):Boolean {
			return tileExistsAt(point) && _boardData.getChessPieceAt(point.x, point.y).colour == ChessPieceColours.WHITE;
		}
		// need to change this to use ChessPieceColours.NONE in the future
		protected function tileIsOccupiedAt(point:Point):Boolean {
			return tileExistsAt(point) && _boardData.getChessPieceAt(point.x, point.y).type != NullChessPiece;
		}
		
		protected function moveIsValidAt(x:int, y:int):Boolean {
			return _boardData.tileExistsAt(x, y) && _boardData.getChessPieceAt(x, y).colour == ChessPieceColours.BLACK;
		}
		
		public function removeSelfFromStage():void {
			parent.removeChild(this);
		}
		
		public function legalMoves():Array {
			throw new Error("Method should only be called on subclass");
		}
		
		public function get tileX():uint {
			return _tx;
		}
		
		public function get tileY():uint {
			return _ty;
		}
	}
}