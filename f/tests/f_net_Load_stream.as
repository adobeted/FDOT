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
			Test.register( this );
			Load.stream( 'http://onflex.org/f/Load/test.png' , loadStream , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadStream( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.SUCCESS ){
				trace( ' < COMPLETE: ' );
				var load:Loader = new Loader()
				load.loadBytes( event.data );
				addChild( load );
				Test.pass( this );
				
			}else if( event.type == LoadEvent.PROGRESS ){
				trace( ' < PROGRESS: ' + event.percent );	
				trace( event.bytesAvailable );
			
			}else if( event.type == LoadEvent.FAIL ){
				Test.fail( this , event.error );
			}
		}
		
	}
}