package {
	import flash.display.*;
	
	/** @author kriswelsh@gmail.com */
	public class Useful extends MovieClip {
		
		/**
		 * Cancels out multiple consecutive calls.
		 */
		public static function gotoAndStopOnce(clip:MovieClip, frame:uint):void {
			if (clip.currentFrame != frame)
				clip.gotoAndStop(frame);
		}
		
		public static function trace2DArray(array:Array):void {
			for (var iuint = 0; i < array.length; i++)
				trace(array[i]);
		}
		
		public static function centerToStage(clip:Sprite, stage:Stage):void {
			clip.x = stage.stageWidth / 2 - clip.width / 2
			clip.y = stage.stageHeight / 2 - clip.height / 2
		}
	}
}