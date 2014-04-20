package  {
	import flash.events.*;
	import flash.utils.Timer;
	
	public class Util {
		public static function delayCall(functionToCall:Function, delay:uint):void {
			var timer:Timer = new Timer(delay, 1);
			var handler:Function = function(e:Event) {
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handler);
				functionToCall();
			}
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, handler);
			timer.start();
		}
	}
}