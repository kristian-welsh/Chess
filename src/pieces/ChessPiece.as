﻿package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class ChessPiece extends MovieClip {
		public var _black:Boolean;
		public var _type:Class;
		public var _tx:int;
		public var _ty:int;
		
		protected var _boardData:BoardData;
		protected var _upTiles:int;
		protected var _downTiles:int;
		protected var _leftTiles:int;
		protected var _rightTiles:int;
		protected var _upLeftTiles:int;
		protected var _upRightTiles:int;
		protected var _downLeftTiles:int;
		protected var _downRightTiles:int;
		
		//NEXT TO OPTIMISE: COMBINE ALL DIAGONAL AND NON-DIAGONAL CALCULATIONS IN ONE FUNCTION (SEPERATE) (ADDITIONAL UP FOR PAWN)
		public function ChessPiece(position:Point, type:Class, black:Boolean, container:DisplayObjectContainer, boardData:BoardData):void {
			super();
			updatePosition(position);
			_tx = Math.floor(x / 36);
			_ty = Math.floor(y / 36);
			container.addChild(this);
			_boardData = boardData;
			updatePiece(type, black);
		}
		
		private function updatePosition(position:Point):void {
			this.x = position.x;
			this.y = position.y;
		}
		
		public function updatePiece(type:Class, black:Boolean):void {
			setType(type);
			if (black)
				setBlack();
			else
				setWhite();
		}
		
		/// would idealy be a set fuction, but a bug in flashplayer means you can't have a private setter and public getter or vice versa
		protected function setType(value:Class):void {
			_type = value;
			if (value == NullChessPiece)
				this.visible = false;
			else
				this.visible = true;
		}
		
		public function get type():Class {
			return _type
		}
		
		public function get black():Boolean {
			return _black
		}
		
		private function setBlack():void {
			_black = true;
			displayBlack();
		}
		
		protected function displayBlack():void {
			throw new Error("Should only be called on a sub-class");
		}
		
		protected function setWhite():void {
			_black = false;
			displayWhite();
		}
		
		protected function displayWhite():void {
			throw new Error("Should only be called on a sub-class");
		}
		
		protected function nonDiagonalMovement(limit:int):Array {
			var upTiles:uint = upMovement(limit);
			var downTiles:uint = downMovement(limit);
			var leftTiles:uint = leftMovement(limit);
			var rightTiles:uint = rightMovement(limit);
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
			var upLeftTiles:uint = upLeftMovement(limit);
			var upRightTiles:uint = upRightMovement(limit);
			var downLeftTiles:uint = downLeftMovement(limit);
			var downRightTiles:uint = downRightMovement(limit);
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
		 * @example pathLength(3, 1, -1); looks 3 spaces towards the upper-right of the piece's position.
		 */
		private function pathLength(limit:uint, xDirection:Number, yDirection:Number):uint {
			invalidatePathLengthInputs(xDirection, yDirection);
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
		
		private function invalidatePathLengthInputs(xDirection:Number, yDirection:Number):void {
			if (xDirection != -1 && xDirection != 0 && xDirection != 1)
				throw new Error("xDirection needs to be either -1, 0, or 1. xDirection was:" + xDirection);
			if (yDirection != -1 && yDirection != 0 && yDirection != 1)
				throw new Error("yDirection needs to be either -1, 0, or 1. yDirection was:" + yDirection);
		}
		
		private function tileExistsAt(point:Point):Boolean {
			return _boardData.tileExistsAt(point.y, point.x);
		}
		
		protected function tileIsWhiteAt(point:Point):Boolean {
			return tileExistsAt(point) && !_boardData.getChessPieceAt(point.y, point.x).black;
		}
		
		protected function tileIsOccupiedAt(point:Point):Boolean {
			return tileExistsAt(point) && _boardData.getChessPieceAt(point.y, point.x).type != NullChessPiece;
		}
		
		public function removeSelfFromStage():void {
			parent.removeChild(this);
		}
	}
}