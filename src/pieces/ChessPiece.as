package pieces {
	import flash.display.MovieClip;
	
	public class ChessPiece extends MovieClip {
		public var _black:Boolean;
		public var _type:int;
		public var _tx:int;
		public var _ty:int;
		
		protected var _main:Main;
		protected var U_tiles:int;
		protected var D_tiles:int;
		protected var L_tiles:int;
		protected var R_tiles:int;
		protected var UL_tiles:int;
		protected var UR_tiles:int;
		protected var DL_tiles:int;
		protected var DR_tiles:int;
		protected var i:int;
		
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
		
		protected function loopVERTS(I:int):Array {
			var returnvar:Array = []
			for (i = 1; i < I + 1; i++) {
				if (L_tiles >= i) {
					returnvar.push([_tx - i, _ty]);
				}
				if (U_tiles >= i) {
					returnvar.push([_tx, _ty - i]);
				}
				if (R_tiles >= i) {
					returnvar.push([_tx + i, _ty]);
				}
				if (D_tiles >= i) {
					returnvar.push([_tx, _ty + i]);
				}
			}
			return returnvar;
		}
		
		protected function loopDIAGS(I:int):Array {
			var returnvar:Array = []
			for (i = 1; i < I + 1; i++) {
				if (UL_tiles >= i) {
					returnvar.push([_tx - i, _ty - i]);
				}
				if (UR_tiles >= i) {
					returnvar.push([_tx + i, _ty - i]);
				}
				if (DL_tiles >= i) {
					returnvar.push([_tx - i, _ty + i]);
				}
				if (DR_tiles >= i) {
					returnvar.push([_tx + i, _ty + i]);
				}
			}
			return returnvar;
		}
		
		protected function foward(NUM:uint):uint {
			var i:int;
			for (i = 0; i < NUM; i++) {
				if (_main.boardData[_ty - i - 1]) {
					if (_main.boardData[_ty - i - 1][_tx][1] == 0) {
						return i;
					}
					if (_main.boardData[_ty - i - 1][_tx][1] == 1 && _main.boardData[_ty - i - 1][_tx][0] > 0) {
						return i + 1;
					}
				} else {
					return i;
				}
			}
			return NUM;
		}
		
		protected function back(NUM:uint):uint {
			var i:int;
			for (i = 0; i < NUM; i++) {
				if (_main.boardData[_ty + i + 1]) {
					if (_main.boardData[_ty + i + 1][_tx][1] == 0) {
						return i;
					}
					if (_main.boardData[_ty + i + 1][_tx][1] == 1 && _main.boardData[_ty + i + 1][_tx][0] > 0) {
						return i + 1;
					}
				} else {
					return i;
				}
			}
			return NUM;
		}
		
		protected function left(NUM:uint):uint {
			var i:int;
			for (i = 0; i < NUM; i++) {
				if (_main.boardData[_ty][_tx - i - 1]) {
					if (_main.boardData[_ty][_tx - i - 1][1] == 0) {
						return i;
					}
					if (_main.boardData[_ty][_tx - i - 1][1] == 1 && _main.boardData[_ty][_tx - i - 1][0] > 0) {
						return i + 1;
					}
				} else {
					return i;
				}
			}
			return NUM;
		}
		
		protected function right(NUM:uint):uint {
			var i:int;
			for (i = 0; i < NUM; i++) {
				if (_main.boardData[_ty][_tx + i + 1]) {
					if (_main.boardData[_ty][_tx + i + 1][1] == 0) {
						return i;
					}
					if (_main.boardData[_ty][_tx + i + 1][1] == 1 && _main.boardData[_ty][_tx + i + 1][0] > 0) {
						return i + 1;
					}
				} else {
					return i;
				}
			}
			return NUM;
		}
		
		protected function UL(NUM:uint):uint {
			var i:int;
			for (i = 0; i < NUM; i++) {
				if (_main.boardData[_ty - i - 1] && _main.boardData[_ty - i - 1][_tx - i - 1]) {
					if (_main.boardData[_ty - i - 1][_tx - i - 1][1] == 0) {
						return i;
					}
					if (_main.boardData[_ty - i - 1][_tx - i - 1][1] == 1 && _main.boardData[_ty - i - 1][_tx - i - 1][0] > 0) {
						return i + 1;
					}
				} else {
					return i;
				}
			}
			return NUM;
		}
		
		protected function UR(NUM:uint):uint {
			var i:int;
			for (i = 0; i < NUM; i++) {
				if (_main.boardData[_ty - i - 1] && _main.boardData[_ty - i - 1][_tx + i + 1]) {
					if (_main.boardData[_ty - i - 1][_tx + i + 1][1] == 0) {
						return i;
					}
					if (_main.boardData[_ty - i - 1][_tx + i + 1][1] == 1 && _main.boardData[_ty - i - 1][_tx + i + 1][0] > 0) {
						return i + 1;
					}
				} else {
					return i;
				}
			}
			return NUM;
		}
		
		protected function DL(NUM:uint):uint {
			var i:int;
			for (i = 0; i < NUM; i++) {
				if (_main.boardData[_ty + i + 1] && _main.boardData[_ty + i + 1][_tx - i - 1]) {
					if (_main.boardData[_ty + i + 1][_tx - i - 1][1] == 0) {
						return i;
					}
					if (_main.boardData[_ty + i + 1][_tx - i - 1][1] == 1 && _main.boardData[_ty + i + 1][_tx - i - 1][0] > 0) {
						return i + 1;
					}
				} else {
					return i;
				}
			}
			return NUM;
		}
		
		protected function DR(NUM:uint):uint {
			for (var i:int = 0; i < NUM; i++) {
				if (_main.boardData[_ty + i + 1] && _main.boardData[_ty + i + 1][_tx + i + 1]) {
					if (_main.boardData[_ty + i + 1][_tx + i + 1][1] == 0) {
						return i;
					}
					if (_main.boardData[_ty + i + 1][_tx + i + 1][1] == 1 && _main.boardData[_ty + i + 1][_tx + i + 1][0] > 0) {
						return i + 1;
					}
				} else {
					return i;
				}
			}
			return NUM;
		}
		
		public function removeSelfFromStage():void {
			parent.removeChild(this);
		}
	}
}