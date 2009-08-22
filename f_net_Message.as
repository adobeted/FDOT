package {
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import f.net.Message;
	
	public class f_net_Message extends Sprite
	{
		public function f_net_Message()
		{
			var start:int = getTimer();
			
			Message.add( this.simple , 'foo.boo.goo.doo' );
			Message.add( this.hard   , 'foo.lou.goo.doo2' );
			Message.add( this.harder   , 'foo.lou.boo' );
			trace('----')
			Message.send( { foo:"bar" } );
			Message.send( { foo:"bar" } , 'foo.boo' );
			Message.send( { foo:"bar" } , 'foo.lou' );
			trace('----')
			Message.send( { foo:"bar" } , 'foo.boo.goo' );
			Message.send( { foo:"bar" } , 'hard' );
			Message.send( { foo:"bar" } , 'simple' );
			trace( getTimer() - start);
		}
		
		public function simple( e:Object ):void{ trace('simple'); }
		
		public function hard( e:Object ):void{ trace('hard'); }
		
		public function harder( e:Object ):void{ trace('harder'); }
		
	}
}
