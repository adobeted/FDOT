package f.tests
{
	import f.net.Load;
	import f.events.LoadEvent;
	
	import flash.display.Sprite;

	public class f_net_Load_text_instance extends Sprite
	{
		public function f_net_Load_text_instance()
		{	
			var ld:Load = new Load();
			ld.url = "http://onflex.org/f/Load/test.txt";
			ld.parameters = { method:'post', data:{ a:12345 }};
			ld.resultFormat = Load.TEXT;
			ld.addEventListener( LoadEvent.SUCCESS , loadSuccess );
			ld.addEventListener( LoadEvent.PROGRESS , loadProgress );
			ld.addEventListener( LoadEvent.FAIL , loadFail );
			ld.load();
		}
		
		public function loadProgress( event:LoadEvent ):void
		{
			trace( ' < loadMovie PROGRESS: ' + event.percent );	
		}
		public function loadSuccess( event:LoadEvent ):void
		{
			trace( ' < loadMovie SUCCESS: ' + event.data );	
		}
		public function loadFail( event:LoadEvent ):void
		{
			throw new Error( 'FAIL-FAIL-FAIL' + event.status );
		}
	}
}