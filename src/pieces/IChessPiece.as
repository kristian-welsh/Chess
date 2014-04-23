package pieces {
	
	public interface IChessPiece {
		function legalMoves():Array;
		function removeSelfFromStage():void;
		function get type():Class;
		function get colour():ChessPieceColour;
		function get tileX():uint;
		function get tileY():uint;
	}
}