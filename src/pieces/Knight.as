package pieces {
	
	/** @author Kristian Welsh */
	public class Knight extends ChessPiece implements IChessPiece {
		public function Knight(x:Number, y:Number, black:Boolean, parent:Main):void {
			super(x, y, 3, black, parent);
		}
		
		//if statements may be optimizeable ((true,false,false,true) as opposed to (_ty+2>=0,_tx-1>=0,true,false))
		public function legalMoves():Array {
			var possibleMoves:Array = [];
			possibleMoves.push(knightMove(_ty - 1, _tx - 2, _ty - 1 >= 0, _tx - 2 >= 0));
			possibleMoves.push(knightMove(_ty - 1, _tx + 2, _ty - 1 >= 0, true));
			possibleMoves.push(knightMove(_ty + 1, _tx - 2, true, _tx - 2 >= 0));
			possibleMoves.push(knightMove(_ty + 1, _tx + 2, true, true));
			possibleMoves.push(knightMove(_ty - 2, _tx - 1, _ty - 2 >= 0, _tx - 1 >= 0));
			possibleMoves.push(knightMove(_ty - 2, _tx + 1, _ty - 2 >= 0, true));
			possibleMoves.push(knightMove(_ty + 2, _tx - 1, true, _tx - 1 >= 0));
			possibleMoves.push(knightMove(_ty + 2, _tx + 1, true, true));
			
			var validMoves:Array = [];
			for (var i:uint = 0; i < possibleMoves.length; i++) {
				if (possibleMoves[i] != 0) {
					validMoves.push(possibleMoves[i]);
				}
			}
			return validMoves;
		}
		
		private function knightMove(A:int, B:int, C:Boolean, D:Boolean):Array {
			var returnvar:Array = []
			var arrL1:int = _main.boardData.length - 1;
			var arrL2:int = _main.boardData[0].length - 1;
			if (arrL1 >= (A) && arrL2 >= B && C && D) {
				if (_main.boardData[A][B][1] == 1) {
					returnvar = [B, A];
				} else {
					return [];
				}
			}
			return returnvar;
		}
	}
}