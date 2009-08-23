package f.tests
{
	import f.events.LoadEvent;
	import f.net.Load;
	
	import flash.display.Loader;
	import flash.display.Sprite;

	public class f_net_Load_image_instance extends Sprite
	{
		public function f_net_Load_image_instance()
		{	
			Test.register( this );
			var ld:Load = new Load();
			ld.url = "http://onflex.org/f/Load/test.png";
			ld.parameters = { method:'post', data:{ a:12345 }};
			ld.resultFormat = Load.IMAGE;
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
			trace( ' < SUCCESS: ' );
			//event.data is a Loader
			this.addChild( event.data );
			Test.pass( this ); 
		}
		
		public function loadProgress( event:LoadEvent ):void
		{
			//trace( ' < PROGRESS: ' + event.percent );	
			
			if( event.percent > 50 ) Load(event.currentTarget).unload();
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