package pieces {
	
	/** @author Kristian Welsh */
	public interface IChessPiece {
		function updatePiece(type:int, black:Boolean):void;
		function legalMoves():Array;
		function removeSelfFromStage():void;
		function get type():int;
		function get black():Boolean;
		function get x():Number;
		function get y():Number;
	}
}