package f.tests
{
	import f.events.LoadEvent;
	import f.net.Load;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLStream;

	public class f_net_Load_stream extends Sprite
	{
		public function f_net_Load_stream():void
		{
			Load.stream( 'http://onflex.org/f/Load/test.png' , loadStream , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadStream( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.SUCCESS ){
				trace( ' < Load.stream COMPLETE: ' );
				var load:Loader = new Loader()
				load.loadBytes( event.data );
				addChild( load );
				
			}else if( event.type == LoadEvent.PROGRESS ){
				trace( ' < Load.stream PROGRESS: ' + event.percent );	
				trace( event.bytesAvailable );
			
			}else if( event.type == LoadEvent.FAIL ){
				throw new Error( 'FAIL-FAIL-FAIL' + event.status );
			}
		}
		
	}
}