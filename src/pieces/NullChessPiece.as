package pieces {
	import board.BoardData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class NullChessPiece extends ChessPiece implements IChessPiece {
		public function NullChessPiece(position:Point, colour:String, boardData:BoardData):void {
			_type = NullChessPiece;
			_blackFrameNumber = 0;
			super(position, colour, boardData);
			this.visible = false;
		}
		
		public override function legalMoves():Array {
			return [];
		}
	}
}