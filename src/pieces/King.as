package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class King extends ChessPiece implements IChessPiece {
		public function King(position:Point, black:Boolean, container:DisplayObjectContainer, boardData:BoardData):void {
			super(position, King, black, container, boardData);
		}
		
		public function legalMoves():Array {
			return nonDiagonalMovement(1).concat(diagonalMovement(1));
		}
		
		protected override function displayWhite():void {
			this.gotoAndStop(12 - 1)
		}
		
		protected override function displayBlack():void {
			this.gotoAndStop(12);
		}
	}
}