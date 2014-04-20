package pieces {
	
	/** @author Kristian Welsh */
	public interface IChessPiece {
		function legalMoves():Array;
		function removeSelfFromStage():void;
		function get type():Class;
		function get black():Boolean;
		function get x():Number;
		function get y():Number;
	}
}