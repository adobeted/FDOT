package f.tests
{
	import f.events.LoadEvent;
	import f.net.Load;
	import flash.display.Loader;
	import flash.display.Sprite;

	public class f_net_Load_binary_instance extends Sprite
	{
		public function f_net_Load_binary_instance()
		{	
			Test.register( this );
			var ld:Load = new Load();
			ld.url = "http://onflex.org/f/Load/test.png";
			ld.parameters = { method:'post', data:{ a:12345 }};
			ld.resultFormat = Load.BINARY;
			ld.addEventListener( LoadEvent.SUCCESS , loadSuccess );
			ld.addEventListener( LoadEvent.PROGRESS , loadProgress );
			ld.addEventListener( LoadEvent.FAIL , loadFail );
			ld.load();
		}
		
		public function loadSuccess( event:LoadEvent ):void
		{
			trace( ' < SUCCESS: ' );
			var ld:Loader = new Loader();
			//event.data is a byteArray
			ld.loadBytes( event.data );
			this.addChild( ld );
			Test.pass( this );
		}

		public function loadProgress( event:LoadEvent ):void
		{
			trace( ' < PROGRESS: ' + event.percent );	
		}
				
		public function loadFail( event:LoadEvent ):void
		{
			Test.fail( this , event.error );
		}
	}
}