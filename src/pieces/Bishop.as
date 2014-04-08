package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class Bishop extends ChessPiece implements IChessPiece {
		public function Bishop(position:Point, black:Boolean, container:DisplayObjectContainer, boardData:BoardData):void {
			super(position, Bishop, black, container, boardData);
		}
		
		public function legalMoves():Array {
			return diagonalMovement(7);
		}
		
		protected override function displayWhite():void {
			this.gotoAndStop(8 - 1)
		}
		
		protected override function displayBlack():void {
			this.gotoAndStop(8);
		}
	}
}