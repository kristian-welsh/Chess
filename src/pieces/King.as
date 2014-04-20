package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class King extends ChessPiece implements IChessPiece {
		public function King(position:Point, black:Boolean, boardData:BoardData):void {
			_type = King;
			_blackFrameNumber = 12
			super(position, black, boardData);
		}
		
		public override function legalMoves():Array {
			return nonDiagonalMovement(1).concat(diagonalMovement(1));
		}
	}
}