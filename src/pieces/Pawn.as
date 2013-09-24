package pieces {
	
	/** @author Kristian Welsh */
	public class Pawn extends ChessPiece implements IChessPiece {
		public function Pawn(x:Number, y:Number, black:Boolean, parent:Main):void {
			super(x, y, 1, black, parent);
		}
		
		public function legalMoves():Array {
			var return_me:Array = [];
			
			if (foward(9) > 1 && _ty == 6 && _main.boardData[_ty - 2][_tx][0] == 0)
				return_me.push([_tx, _ty - 2]);
			
			if (foward(9) > 0 && _main.boardData[_ty - 1][_tx][0] == 0) {
				return_me.push([_tx, _ty - 1]);
			}
			
			if (_ty <= 0)
				return return_me;
			
			if (_main.boardData[0].length - 1 >= _tx + 1 && _main.boardData[_ty - 1][_tx + 1][1] == 1 && _main.boardData[_ty - 1][_tx + 1][0] != 0)
				return_me.push([_tx + 1, _ty - 1]);
			
			if (0 < _tx && _main.boardData[_ty - 1][_tx - 1][1] == 1 && _main.boardData[_ty - 1][_tx - 1][0] != 0)
				return_me.push([_tx - 1, _ty - 1]);
			
			return return_me;
		}
	}
}