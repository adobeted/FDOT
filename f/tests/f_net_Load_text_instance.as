package f.tests
{
	import f.net.Load;
	import f.events.LoadEvent;
	
	import flash.display.Sprite;

	public class f_net_Load_text_instance extends Sprite
	{
		public function f_net_Load_text_instance()
		{	
			Test.register( this );
			var ld:Load = new Load();
			ld.url = "http://onflex.org/f/Load/test.txt";
			ld.parameters = { method:'post', data:{ a:12345 }};
			ld.resultFormat = Load.TEXT;
			ld.addEventListener( LoadEvent.OPEN , loadOpen );
			ld.addEventListener( LoadEvent.CLOSE , loadClose );
			ld.addEventListener( LoadEvent.INIT , loadInit );
			ld.addEventListener( LoadEvent.SUCCESS , loadSuccess );
			ld.addEventListener( LoadEvent.PROGRESS , loadProgress );
			ld.addEventListener( LoadEvent.FAIL , loadFail );
			ld.load();
		}
		
		public function loadSuccess( event:LoadEvent ):void
		{
			if( event.data.split( ' ')[0] == 'Lorem' ){
				trace( ' < SUCCESS' );
				Test.pass( this );
			}else{
				Test.fail( this , 'INVALID DATA TEST' );
			}
		}
		
		public function loadProgress( event:LoadEvent ):void
		{
			//trace( ' < PROGRESS: ' + event.percent );	
		}
		
		public function loadOpen( event:LoadEvent ):void
		{
			trace( ' < OPEN: ' );	
		}
		
		public function loadClose( event:LoadEvent ):void
		{
			trace( ' < CLOSE: ' );	
		}
		
		public function loadInit( event:LoadEvent ):void
		{
			trace( ' < INIT: ' );	
		}
		
		public function loadFail( event:LoadEvent ):void
		{
			Test.fail( this , event.error );
		}
	}
}