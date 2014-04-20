package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class NullChessPiece extends ChessPiece implements IChessPiece {
		public function NullChessPiece(position:Point, black:Boolean, boardData:BoardData):void {
			_type = NullChessPiece;
			_blackFrameNumber = 0;
			super(position, black, boardData);
			this.visible = false;
		}
		
		public override function legalMoves():Array {
			return [];
		}
	}
}