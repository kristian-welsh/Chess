package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class Rook extends ChessPiece implements IChessPiece {
		public function Rook(position:Point, black:Boolean, container:DisplayObjectContainer, boardData:BoardData):void {
			super(position, Rook, black, container, boardData);
		}
		
		public function legalMoves():Array {
			return nonDiagonalMovement(7);
		}
		
		protected override function displayWhite():void {
			this.gotoAndStop(4 - 1)
		}
		
		protected override function displayBlack():void {
			this.gotoAndStop(4);
		}
	}
}