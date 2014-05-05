package pieces {
	public interface IChessPiece {
		function legalMoves():Array; // move to a vector of points in the future
		function removeSelfFromParent():void;
		function get type():Class;
		function get colour():ChessPieceColour;
		function get tileX():uint;
		function get tileY():uint;
	}
}