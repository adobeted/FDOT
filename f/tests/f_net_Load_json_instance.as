package f.tests
{
	import f.net.Load;
	import f.events.LoadEvent;
	
	import flash.display.Sprite;

	public class f_net_Load_json_instance extends Sprite
	{
		public function f_net_Load_json_instance()
		{	
			Test.register( this );
			var ld:Load = new Load();
			ld.url = "http://onflex.org/f/Load/test.json";
			ld.parameters = { method:'post', data:{ a:12345 }};
			ld.resultFormat = Load.JSON;
			ld.addEventListener( LoadEvent.SUCCESS , loadSuccess );
			ld.addEventListener( LoadEvent.PROGRESS , loadProgress );
			ld.addEventListener( LoadEvent.FAIL , loadFail );
			ld.load();
		}
		
		public function loadSuccess( event:LoadEvent ):void
		{
			trace( ' < SUCCESS: ' + event.data );
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