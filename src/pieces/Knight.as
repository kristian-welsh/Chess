package pieces {
	import board.BoardData;
	import flash.geom.Point;
	
	public class Knight extends ChessPiece implements IChessPiece {
		private var _currentLegalMoves:Array;
		
		public function Knight(tileCoordinates:Point, black:Boolean, boardData:BoardData):void {
			_type = Knight;
			_blackFrameNumber = 6
			super(tileCoordinates, black, boardData);
		}
		
		public override function legalMoves():Array {
			_currentLegalMoves = [];
			
			addMoveIfValid(_tx - 2, _ty - 1);
			addMoveIfValid(_tx + 2, _ty - 1);
			addMoveIfValid(_tx - 2, _ty + 1);
			addMoveIfValid(_tx + 2, _ty + 1);
			addMoveIfValid(_tx - 1, _ty - 2);
			addMoveIfValid(_tx + 1, _ty - 2);
			addMoveIfValid(_tx - 1, _ty + 2);
			addMoveIfValid(_tx + 1, _ty + 2);
			
			return _currentLegalMoves;
		}
		
		private function addMoveIfValid(x:int, y:int):void {
			if (moveIsValidAt(x, y))
				_currentLegalMoves.push(new Point(x, y));
		}
	}
}