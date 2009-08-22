package f.events
{
	import flash.events.Event;

	public class LoadEvent extends Event
	{
		public static const OPEN:String = 'f.events.LoadEvent.OPEN';
		public static const CLOSE:String = 'f.events.LoadEvent.CLOSE';
		public static const PROGRESS:String = 'f.events.LoadEvent.PROGRESS';
		public static const SUCCESS:String = 'f.events.LoadEvent.SUCCESS';
		public static const FAIL:String = 'f.events.LoadEvent.FAIL';
		public static const INIT:String = 'f.events.LoadEvent.INIT';
		
		public var data:* = null;
		public var loader:Object = null;
		public var percent:Number = 0;
		public var bytesLoaded:int = 0;
		public var bytesTotal:int = 0;
		public var bytesAvailable:int = 0;
		public var error:String = null;
		public var status:String = null;

		public function LoadEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}