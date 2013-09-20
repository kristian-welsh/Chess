package {
	import ChessPiece;
	import flash.display.*;
	import flash.events.Event;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class Cursor extends MovieClip {
		private var _main:Main;
		private var _stage:DisplayObjectContainer;
		private var _tx:int; //x value of the tile you are hovering over
		private var _ty:int; //y value of the tile you are hovering over
		private var _iy:int; //arr[_iy], data_arr[_iy]
		private var _ix:int; //arr[_iy][_ix], data_arr[_iy][_ix]
		private var _selectedTile:ChessPiece; //the piece you have currently selected
		private var _legalMoveIndictors:Array = []; //this array holds all of the buttons for legal moves from your selected piece
		private var tets:Timer = new Timer(1, 1); //this timer makes you need to click again to select the piece you just moved
		
		public function Cursor(STAGE:DisplayObjectContainer):void {
			_stage = STAGE;
			this.addEventListener(Event.ADDED_TO_STAGE, listen);
		}
		
		public function listen(event:Event) {
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, moveCursor);
			_stage.addEventListener(MouseEvent.CLICK, selectPiece);
		}
		
		public function moveCursor(event:MouseEvent) {
			_tx = Math.floor((_stage.mouseX - 12) / 36) * 36 + 12;
			_ty = Math.floor((_stage.mouseY - 12) / 36) * 36 + 12;
			_ix = Math.floor(_tx / 36);
			_iy = Math.floor(_ty / 36);
			if (!_selectedTile) {
				if (_ty >= 0 && _ty < 300 && _tx >= 0 && _tx < 300) {
					this.visible = true;
				} else {
					this.visible = false;
				}
				this.x = _tx;
				this.y = _ty;
			}
			_stage.addEventListener(MouseEvent.CLICK, selectPiece);
		}
		
		private function selectPiece(event:MouseEvent) {
			var legal_moves:Array = [];
			_main = this.parent as Main;
			if (_iy < 8 && _ix < 8 && _iy > -1 && _ix > -1) {
				if (!(_main._chessPieces[_iy][_ix]._black)) {
					if (this.currentFrame == 1) {
						_selectedTile = _main._chessPieces[_iy][_ix];
						this.gotoAndStop(2);
						legal_moves = _selectedTile.legalMoves();
						for (var i = 0; i < legal_moves.length; i++) {
							_legalMoveIndictors[i] = new validMove(); //
							_legalMoveIndictors[i].x = legal_moves[i][0] * 36 + 14;
							_legalMoveIndictors[i].y = legal_moves[i][1] * 36 + 14;
							_legalMoveIndictors[i].addEventListener(MouseEvent.CLICK, makeMove);
							_main.addChild(_legalMoveIndictors[i]);
						}
					} else {
						if (_main._chessPieces[_iy][_ix] == _selectedTile) {
							_selectedTile = null;
							this.gotoAndStop(1);
							for (i = 0; i < _legalMoveIndictors.length; i++) {
								_main.removeChild(_legalMoveIndictors[i]);
							}
							_legalMoveIndictors = [];
						}
					}
				}
			}
		}
		
		private function makeMove(event:MouseEvent) {
			for (var i:int = 0; i < _legalMoveIndictors.length; i++) {
				_legalMoveIndictors[i].removeEventListener(MouseEvent.CLICK, makeMove);
				_legalMoveIndictors[i].parent.removeChild(_legalMoveIndictors[i]);
			}
			
			var target_y:int = Math.floor(event.target.y / 36);
			var target_x:int = Math.floor(event.target.x / 36);
			_main._chessPieces[target_y][target_x].updatePiece(_selectedTile._type, false);
			_main.boardData[target_y][target_x] = [_selectedTile._type, _selectedTile._black];
			_selectedTile.updatePiece(0, true);
			_main.boardData[Math.floor(_selectedTile.y / 36)][Math.floor(_selectedTile.x / 36)] = [0, 1];
			
			this.gotoAndStop(1);
			
			_legalMoveIndictors = [];
			_selectedTile = null;
			tets.addEventListener(TimerEvent.TIMER, replenishListener);
			this.x = _tx;
			this.y = _ty;
			
			if (_main._chessPieces[target_y][target_x]._type == 1) {
				if (_main._chessPieces[target_y][target_x]._ty == 0) {
					_main._chessPieces[target_y][target_x].updatePiece(5, false);
				}
			}
			_stage.removeEventListener(MouseEvent.CLICK, selectPiece); //COMMENT OUT TO RESELECT PIECE ON MOVE
			tets.start();
		}
		
		private function replenishListener(event:TimerEvent) {
			_stage.addEventListener(MouseEvent.CLICK, selectPiece);
		}
	}
}