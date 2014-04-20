package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class Rook extends ChessPiece implements IChessPiece {
		public function Rook(position:Point, black:Boolean, boardData:BoardData):void {
			_type = Rook;
			_blackFrameNumber = 4;
			super(position, black, boardData);
		}
		
		public override function legalMoves():Array {
			return nonDiagonalMovement(7);
		}
	}
}