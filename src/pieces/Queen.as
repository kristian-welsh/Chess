package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class Queen extends ChessPiece implements IChessPiece {
		public function Queen(position:Point, black:Boolean, container:DisplayObjectContainer, boardData:BoardData):void {
			super(position, Queen, black, container, boardData);
		}
		
		public function legalMoves():Array {
			return nonDiagonalMovement(7).concat(diagonalMovement(7));
		}
		
		protected override function displayWhite():void {
			this.gotoAndStop(10 - 1)
		}
		
		protected override function displayBlack():void {
			this.gotoAndStop(10);
		}
	}
}