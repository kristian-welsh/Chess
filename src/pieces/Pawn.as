package pieces {
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class Pawn extends ChessPiece implements IChessPiece {
		public function Pawn(x:Number, y:Number, black:Boolean, parent:Main):void {
			super(x, y, 1, black, parent);
		}
		public function legalMoves():Array {
			var returnMe:Array = [];
			
			if (upMovement(2) == 2 && !tileIsOccupiedAt(new Point(_tx, _ty - upMovement(2))) && _ty == 6)
				returnMe.push(new Point(_tx, _ty - upMovement(2)));
			
			if (upMovement(1) > 0 && !tileIsOccupiedAt(new Point(_tx, _ty - upMovement(1))))
				returnMe.push(new Point(_tx, _ty - upMovement(1)));
			
			if (tileIsOccupiedAt(new Point(_tx - 1, _ty - 1)) && !tileIsWhiteAt(new Point(_tx - 1, _ty - 1)))
				returnMe.push(new Point(_tx - 1, _ty - 1));
			
			if (tileIsOccupiedAt(new Point(_tx + 1, _ty - 1)) && !tileIsWhiteAt(new Point(_tx + 1, _ty - 1)))
				returnMe.push(new Point(_tx + 1, _ty - 1));
			
			return returnMe;
		}
	}
}