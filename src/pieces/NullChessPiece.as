package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class NullChessPiece extends ChessPiece implements IChessPiece {
		public function NullChessPiece(position:Point, black:Boolean, container:DisplayObjectContainer, boardData:BoardData):void {
			super(position, NullChessPiece, black, container, boardData);
			this.visible = false;
		}
		
		public function legalMoves():Array {
			return [];
		}
		
		protected override function displayWhite():void {
			
		}
		
		protected override function displayBlack():void {
			
		}
	}
}