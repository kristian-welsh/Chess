package pieces.specified {
	import board.BoardData;
	import flash.geom.Point;
	import pieces.*;

	public class Pawn extends ChessPiece implements IChessPiece {
		public function Pawn(tileCoordinates:Point, colour:ChessPieceColour, boardData:BoardData):void {
			_type = Pawn;
			_blackFrameNumber = 2;
			super(tileCoordinates, colour, boardData);
		}

		public override function legalMoves():Vector.<Point> {
			var returnMe:Vector.<Point> = new Vector.<Point>();
			if (upMovement(2) == 2 && !tileIsOccupiedAt(new Point(_tx, _ty - upMovement(2))) && _ty == 6)
				returnMe.push(new Point(_tx, _ty - upMovement(2)));
			if (upMovement(1) > 0 && !tileIsOccupiedAt(new Point(_tx, _ty - upMovement(1))))
				returnMe.push(new Point(_tx, _ty - upMovement(1)));
			if (topLeftIsBlack())
				returnMe.push(topLeftTilePosition());
			if (topRightIsBlack())
				returnMe.push(topRightTilePosition());
			return returnMe;
		}

		private function topLeftIsBlack():Boolean {
			return tileIsBlackAt(topLeftTilePosition());
		}

		private function topLeftTilePosition():Point {
			return new Point(_tx - 1, _ty - 1);
		}

		private function topRightIsBlack():Boolean {
			return tileIsBlackAt(topRightTilePosition());
		}

		private function topRightTilePosition():Point {
			return new Point(_tx + 1, _ty - 1);
		}
	}
}