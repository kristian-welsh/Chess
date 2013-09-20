package {
	import flash.display.MovieClip;
	
	public class ChessPiece extends MovieClip {
		
		public var _black:Boolean;
		public var _type:int;
		public var _tx:int;
		public var _ty:int;
		
		private var _par:Main;
		private var U_tiles:int;
		private var D_tiles:int;
		private var L_tiles:int;
		private var R_tiles:int;
		private var UL_tiles:int;
		private var UR_tiles:int;
		private var DL_tiles:int;
		private var DR_tiles:int;
		private var i:int;
		
		public function ChessPiece(x:Number, y:Number, type:int, black:Boolean, parent:Main):void {
			this.x = x;
			this.y = y;
			_tx = Math.floor(x / 36)
			_ty = Math.floor(y / 36)
			_par = parent as Main;
			updatePiece(type, black);
		}
		
		public function updatePiece(type:int, black:Boolean) {
			this.type = type;
			if (black)
				setBlack();
			else
				setWhite()
		}
		
		private function set type(value:int):void {
			_type = value;
			if (value == 0)
				this.visible = false;
			else
				this.visible = true;
		}
		
		private function setBlack():void {
			_black = true;
			this.gotoAndStop(_type * 2);
		}
		
		private function setWhite():void {
			_black = false;
			this.gotoAndStop(_type * 2 - 1)
		}
		
		public function legalMoves():Array {
			
			//NEXT TO OPTIMISE: COMBINE ALL DIAGONAL AND NON-DIAGONAL CALCULATIONS IN ONE FUNCTION (SEPERATE) (ADDITIONAL UP FOR PAWN)
			//knight if statement may be optimizeable ((true,false,false,true) as opposed to (_ty+2>=0,_tx-1>=0,true,false))
			U_tiles = foward(7);
			D_tiles = back(7);
			L_tiles = left(7);
			R_tiles = right(7);
			UL_tiles = UL(7);
			UR_tiles = UR(7);
			DL_tiles = DL(7);
			DR_tiles = DR(7);
			var VERTS:Array;
			var DIAGS:Array;
			var i:int;
			var return_me:Array = []
			switch (_type) {
				case 0: //EMPTY
					return [];
					break;
				case 1: //PAWN
					if (U_tiles > 1 && _ty == 6) {
						if (_par.boardData[_ty - 2][_tx][0] == 0) {
							return_me.push([_tx, _ty - 2]);
						}
					}
					if (U_tiles > 0) {
						if (_par.boardData[_ty - 1][_tx][0] == 0) {
							return_me.push([_tx, _ty - 1]);
						}
					}
					var returnvar:Array = []
					var arrW:int = _par.boardData[0].length - 1;
					if (_ty > 0) {
						if (arrW >= _tx + 1) {
							if (_par.boardData[_ty - 1][_tx + 1][1] == 1) {
								if (_par.boardData[_ty - 1][_tx + 1][0] != 0) {
									return_me.push([_tx + 1, _ty - 1]);
								}
							}
						}
						if (0 < _tx) {
							if (_par.boardData[_ty - 1][_tx - 1][1] == 1) {
								if (_par.boardData[_ty - 1][_tx - 1][0] != 0) {
									return_me.push([_tx - 1, _ty - 1]);
								}
							}
						}
					}
					return return_me;
					return returnvar;
					break;
				case 2: //ROOK
					return loopVERTS(7);
					break;
				case 3: //KNIGHT
					/*
						 interesting patern to the arguments of my knight's move function
						 0|00|11
						 0|01|10
						 0|10|01
						 0|11|00
						 1|00|11
						 1|01|10
						 1|10|01
						 1|11|00
					 */
					
					return_me.push(knightMove(_ty - 1, _tx - 2, _ty - 1 >= 0, _tx - 2 >= 0));
					return_me.push(knightMove(_ty - 1, _tx + 2, _ty - 1 >= 0, true));
					return_me.push(knightMove(_ty + 1, _tx - 2, true, _tx - 2 >= 0));
					return_me.push(knightMove(_ty + 1, _tx + 2, true, true));
					return_me.push(knightMove(_ty - 2, _tx - 1, _ty - 2 >= 0, _tx - 1 >= 0));
					return_me.push(knightMove(_ty - 2, _tx + 1, _ty - 2 >= 0, true));
					return_me.push(knightMove(_ty + 2, _tx - 1, true, _tx - 1 >= 0));
					return_me.push(knightMove(_ty + 2, _tx + 1, true, true));
					
					var tmp:Array = [];
					for (i = 0; i < return_me.length; i++) {
						if (return_me[i] != 0) {
							tmp.push(return_me[i]);
						}
					}
					return_me = tmp
					return return_me;
					break;
				case 4: //BISHOP
					return loopDIAGS(7);
					break;
				case 5: //QUEEN
					VERTS = loopVERTS(7);
					for (i = 0; i < VERTS.length; i++) {
						return_me.push(VERTS[i]);
					}
					DIAGS = loopDIAGS(7);
					for (i = 0; i < DIAGS.length; i++) {
						return_me.push(DIAGS[i]);
					}
					return return_me;
					break;
				case 6: //KING
					VERTS = loopVERTS(1);
					for (i = 0; i < VERTS.length; i++) {
						return_me.push(VERTS[i]);
					}
					DIAGS = loopDIAGS(1);
					for (i = 0; i < DIAGS.length; i++) {
						return_me.push(DIAGS[i]);
					}
					return return_me;
					break;
			}
			return [];
		}
		
		private function loopVERTS(I:int):Array {
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
		
		private function loopDIAGS(I:int):Array {
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
		
		public function knightMove(A:int, B:int, C:Boolean, D:Boolean):Array {
			var returnvar:Array = []
			var arrL1:int = _par.boardData.length - 1;
			var arrL2:int = _par.boardData[0].length - 1;
			if (arrL1 >= (A) && arrL2 >= B && C && D) {
				if (_par.boardData[A][B][1] == 1) {
					returnvar = [B, A];
				} else {
					return [];
				}
			}
			return returnvar;
		}
		
		public function foward(NUM):int {
			var i:int;
			for (i = 0; i < NUM; i++) {
				if (_par.boardData[_ty - i - 1]) {
					if (_par.boardData[_ty - i - 1][_tx][1] == 0) {
						return i;
					}
					if (_par.boardData[_ty - i - 1][_tx][1] == 1 && _par.boardData[_ty - i - 1][_tx][0] > 0) {
						return i + 1;
					}
				} else {
					return i;
				}
			}
			return NUM;
		}
		
		public function back(NUM):int {
			var i:int;
			for (i = 0; i < NUM; i++) {
				if (_par.boardData[_ty + i + 1]) {
					if (_par.boardData[_ty + i + 1][_tx][1] == 0) {
						return i;
					}
					if (_par.boardData[_ty + i + 1][_tx][1] == 1 && _par.boardData[_ty + i + 1][_tx][0] > 0) {
						return i + 1;
					}
				} else {
					return i;
				}
			}
			return NUM;
		}
		
		public function left(NUM):int {
			var i:int;
			for (i = 0; i < NUM; i++) {
				if (_par.boardData[_ty][_tx - i - 1]) {
					if (_par.boardData[_ty][_tx - i - 1][1] == 0) {
						return i;
					}
					if (_par.boardData[_ty][_tx - i - 1][1] == 1 && _par.boardData[_ty][_tx - i - 1][0] > 0) {
						return i + 1;
					}
				} else {
					return i;
				}
			}
			return NUM;
		}
		
		public function right(NUM):int {
			var i:int;
			for (i = 0; i < NUM; i++) {
				if (_par.boardData[_ty][_tx + i + 1]) {
					if (_par.boardData[_ty][_tx + i + 1][1] == 0) {
						return i;
					}
					if (_par.boardData[_ty][_tx + i + 1][1] == 1 && _par.boardData[_ty][_tx + i + 1][0] > 0) {
						return i + 1;
					}
				} else {
					return i;
				}
			}
			return NUM;
		}
		
		public function UL(NUM):int {
			var i:int;
			for (i = 0; i < NUM; i++) {
				if (_par.boardData[_ty - i - 1] && _par.boardData[_ty - i - 1][_tx - i - 1]) {
					if (_par.boardData[_ty - i - 1][_tx - i - 1][1] == 0) {
						return i;
					}
					if (_par.boardData[_ty - i - 1][_tx - i - 1][1] == 1 && _par.boardData[_ty - i - 1][_tx - i - 1][0] > 0) {
						return i + 1;
					}
				} else {
					return i;
				}
			}
			return NUM;
		}
		public function UR(NUM):int {
			var i:int;
			for (i = 0; i < NUM; i++) {
				if (_par.boardData[_ty - i - 1] && _par.boardData[_ty - i - 1][_tx + i + 1]) {
					if (_par.boardData[_ty - i - 1][_tx + i + 1][1] == 0) {
						return i;
					}
					if (_par.boardData[_ty - i - 1][_tx + i + 1][1] == 1 && _par.boardData[_ty - i - 1][_tx + i + 1][0] > 0) {
						return i + 1;
					}
				} else {
					return i;
				}
			}
			return NUM;
		}
		public function DL(NUM):int {
			var i:int;
			for (i = 0; i < NUM; i++) {
				if (_par.boardData[_ty + i + 1] && _par.boardData[_ty + i + 1][_tx - i - 1]) {
					if (_par.boardData[_ty + i + 1][_tx - i - 1][1] == 0) {
						return i;
					}
					if (_par.boardData[_ty + i + 1][_tx - i - 1][1] == 1 && _par.boardData[_ty + i + 1][_tx - i - 1][0] > 0) {
						return i + 1;
					}
				} else {
					return i;
				}
			}
			return NUM;
		}
		public function DR(NUM):int {
			var i:int;
			for (i = 0; i < NUM; i++) {
				if (_par.boardData[_ty + i + 1] && _par.boardData[_ty + i + 1][_tx + i + 1]) {
					if (_par.boardData[_ty + i + 1][_tx + i + 1][1] == 0) {
						return i;
					}
					if (_par.boardData[_ty + i + 1][_tx + i + 1][1] == 1 && _par.boardData[_ty + i + 1][_tx + i + 1][0] > 0) {
						return i + 1;
					}
				} else {
					return i;
				}
			}
			return NUM;
		}
	}
}