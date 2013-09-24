﻿package pieces {
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class ChessPiece extends MovieClip {
		public var _black:Boolean;
		public var _type:int;
		public var _tx:int;
		public var _ty:int;
		
		protected var _main:Main;
		protected var _upTiles:int;
		protected var _downTiles:int;
		protected var _leftTiles:int;
		protected var _rightTiles:int;
		protected var _upLeftTiles:int;
		protected var _upRightTiles:int;
		protected var _downLeftTiles:int;
		protected var _downRightTiles:int;
		
		//NEXT TO OPTIMISE: COMBINE ALL DIAGONAL AND NON-DIAGONAL CALCULATIONS IN ONE FUNCTION (SEPERATE) (ADDITIONAL UP FOR PAWN)
		public function ChessPiece(x:Number, y:Number, type:int, black:Boolean, parent:Main):void {
			super();
			this.x = x;
			this.y = y;
			parent.addChild(this);
			_tx = Math.floor(x / 36);
			_ty = Math.floor(y / 36);
			_main = parent as Main;
			updatePiece(type, black);
		}
		
		public function updatePiece(type:int, black:Boolean):void {
			setType(type);
			if (black)
				setBlack();
			else
				setWhite();
		}
		
		/// would idealy be a set fuction, but a bug in flashplayer means you can't have a private setter and public getter or vice versa
		protected function setType(value:int):void {
			_type = value;
			if (value == 0)
				this.visible = false;
			else
				this.visible = true;
		}
		
		public function get type():int {
			return _type
		}
		
		public function get black():Boolean {
			return _black
		}
		
		protected function setBlack():void {
			_black = true;
			this.gotoAndStop(_type * 2);
		}
		
		protected function setWhite():void {
			_black = false;
			this.gotoAndStop(_type * 2 - 1)
		}
		
		protected function axisMovement(limit:int):Array {
			var upTiles:int = upMovement(limit);
			var downTiles:int = downMovement(limit);
			var leftTiles:int = leftMovement(limit);
			var rightTiles:int = rightMovement(limit);
			var returnMe:Array = []
			for (var i:uint = 1; i < limit + 1; i++) {
				if (leftTiles >= i)
					returnMe.push(new Point(_tx - i, _ty));
				if (upTiles >= i)
					returnMe.push(new Point(_tx, _ty - i));
				if (rightTiles >= i)
					returnMe.push(new Point(_tx + i, _ty));
				if (downTiles >= i)
					returnMe.push(new Point(_tx, _ty + i));
			}
			return returnMe;
		}
		
		protected function diagonalMovement(limit:int):Array {
			var upLeftTiles:int = upLeftMovement(limit);
			var upRightTiles:int = upRightMovement(limit);
			var downLeftTiles:int = downLeftMovement(limit);
			var downRightTiles:int = downRightMovement(limit);
			var returnMe:Array = []
			for (var i:uint = 1; i < limit + 1; i++) {
				if (upLeftTiles >= i)
					returnMe.push(new Point(_tx - i, _ty - i));
				if (upRightTiles >= i)
					returnMe.push(new Point(_tx + i, _ty - i));
				if (downLeftTiles >= i)
					returnMe.push(new Point(_tx - i, _ty + i));
				if (downRightTiles >= i)
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
		 */
		private function pathLength(limit:uint, xDirection:Number, yDirection:Number):uint {
			for (var i:int = 0; i < limit; i++) {
				var inspectedPosition:Point = new Point(_tx + i * xDirection + xDirection, _ty + i * yDirection + yDirection);
				if (!tileExistsAt(inspectedPosition))
					return i;
				if (tileIsWhiteAt(inspectedPosition))
					return i;
				if (tileIsOccupiedAt(inspectedPosition))
					return i + 1;
			}
			return limit;
		}
		
		private function tileExistsAt(point:Point):Boolean {
			return _main.boardData[point.y] != null && _main.boardData[point.y][point.x] != null;
		}
		
		protected function tileIsWhiteAt(point:Point):Boolean {
			return tileExistsAt(point) && _main.boardData[point.y][point.x][1] == 0
		}
		
		protected function tileIsOccupiedAt(point:Point):Boolean {
			return tileExistsAt(point) && _main.boardData[point.y][point.x][0] != 0;
		}
		
		public function removeSelfFromStage():void {
			parent.removeChild(this);
		}
	}
}