package pieces.specified {
	import board.BoardData;
	import flash.geom.Point;
	import pieces.*;

	public class NullChessPiece extends ChessPiece implements IChessPiece {
		public function NullChessPiece(position:Point, colour:ChessPieceColour, boardData:BoardData):void {
			_type = NullChessPiece;
			_blackFrameNumber = 0;
			super(position, colour, boardData);
			this.visible = false;
		}

		public override function legalMoves():Vector.<Point> {
			return new Vector.<Point>();
		}
	}
}