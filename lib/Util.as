package {
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class Util {
		/// Calls the first argument after a delay of the seccond argument in milliseconds
		public static function delayCall(delay:uint, functionToCall:Function):void {
			var timer:Timer = new Timer(delay, 1);
			var handler:Function = function(e:Event) {
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handler);
				functionToCall();
			}
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, handler);
			timer.start();
		}
		
		/// Removes a display object from it's parent.
		public static function orphanDisplayObject(child:DisplayObject):void {
			if(child && child.parent)
				child.parent.removeChild(child);
		}
		
		/// Dispatches a CLICK MouseEvent on the argument.
		public static function click(object:IEventDispatcher):void {
			object.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
	}
}