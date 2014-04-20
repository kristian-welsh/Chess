package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class Knight extends ChessPiece implements IChessPiece {
		public function Knight(position:Point, black:Boolean, boardData:BoardData):void {
			_type = Knight;
			_blackFrameNumber = 6
			super(position, black, boardData);
		}
		
		// if statements may be optimizeable ((true,false,false,true) as opposed to (_ty+2>=0,_tx-1>=0,true,false))
		public override function legalMoves():Array {
			var possibleMoves:Array = [];
			//TODO: I don't understand any of this anymore! Clean this pile of mess!!
			pushIfValid(possibleMoves, knightMove(_ty - 1, _tx - 2, _ty - 1 >= 0, _tx - 2 >= 0));
			pushIfValid(possibleMoves, knightMove(_ty - 1, _tx + 2, _ty - 1 >= 0, true));
			pushIfValid(possibleMoves, knightMove(_ty + 1, _tx - 2, true, _tx - 2 >= 0));
			pushIfValid(possibleMoves, knightMove(_ty + 1, _tx + 2, true, true));
			pushIfValid(possibleMoves, knightMove(_ty - 2, _tx - 1, _ty - 2 >= 0, _tx - 1 >= 0));
			pushIfValid(possibleMoves, knightMove(_ty - 2, _tx + 1, _ty - 2 >= 0, true));
			pushIfValid(possibleMoves, knightMove(_ty + 2, _tx - 1, true, _tx - 1 >= 0));
			pushIfValid(possibleMoves, knightMove(_ty + 2, _tx + 1, true, true));
			
			return possibleMoves;
		}
		
		private function pushIfValid(list:Array, move:Point):void {
			if (!move.equals(new Point(-1, -1)))
				list.push(move);
		}
		
		private function knightMove(y:int, x:int, c:Boolean, d:Boolean):Point {
			if (Main.BOARD_HEIGHT - 1 >= y && Main.BOARD_WIDTH - 1 >= x && c && d && _boardData.getChessPieceAt(y, x).black == true)
				return new Point(x, y);
			return new Point(-1, -1);
		}
	}
}