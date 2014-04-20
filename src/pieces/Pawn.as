package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class Pawn extends ChessPiece implements IChessPiece {
		public function Pawn(position:Point, black:Boolean, boardData:BoardData):void {
			_type = Pawn;
			_blackFrameNumber = 2;
			super(position, black, boardData);
		}
		
		public override function legalMoves():Array {
			var returnMe:Array = [];
			if (upMovement(2) == 2 && !tileIsOccupiedAt(new Point(_tx, _ty - upMovement(2))) && _ty == 6)
				returnMe.push(new Point(_tx, _ty - upMovement(2)));
			if (upMovement(1) > 0 && !tileIsOccupiedAt(new Point(_tx, _ty - upMovement(1))))
				returnMe.push(new Point(_tx, _ty - upMovement(1)));
			if (shouldHaveTopLeftLegalMove())
				returnMe.push(new Point(_tx - 1, _ty - 1));
			if (shouldHaveTopRightLegalMove())
				returnMe.push(new Point(_tx + 1, _ty - 1));
			return returnMe;
		}
		
		private function shouldHaveTopLeftLegalMove():Boolean {
			return tileIsOccupiedAt(new Point(_tx - 1, _ty - 1)) && !tileIsWhiteAt(new Point(_tx - 1, _ty - 1));
		}
		
		private function shouldHaveTopRightLegalMove():Boolean {
			return tileIsOccupiedAt(new Point(_tx + 1, _ty - 1)) && !tileIsWhiteAt(new Point(_tx + 1, _ty - 1));
		}
	}
}