package pieces {
	import flash.geom.Point;

	public interface IChessPiece {
		function legalMoves():Vector.<Point>;
		function removeSelfFromParent():void;
		function get type():Class;
		function get colour():ChessPieceColour;
		function get tileX():uint;
		function get tileY():uint;
	}
}