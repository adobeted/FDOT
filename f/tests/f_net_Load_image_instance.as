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
			var ld:Load = new Load();
			ld.url = "http://onflex.org/f/Load/test.png";
			ld.parameters = { method:'post', data:{ a:12345 }};
			ld.resultFormat = Load.IMAGE;
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
			trace( ' < loadMovie SUCCESS: ' );
			//event.data is a Loader
			this.addChild( event.data ); 
		}
		public function loadFail( event:LoadEvent ):void
		{
			throw new Error( 'FAIL-FAIL-FAIL' + event.status );
		}
		
	}
}