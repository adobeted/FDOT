package f.tests
{
	import f.events.LoadEvent;
	import f.net.Load;
	
	import flash.display.Sprite;

	public class f_net_Load_querystring extends Sprite
	{
		public function f_net_Load_querystring():void
		{
			Test.register( this );
			Load.querystring( 'http://onflex.org/f/Load/test.query' , this.loadQuerystring , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadQuerystring( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.SUCCESS ){
				trace( ' < SUCCESS: ' + event.data.field2 );
				Test.pass( this );		
			
			}else if( event.type == LoadEvent.PROGRESS ){
				trace( ' < PROGRESS: ' + event.percent );	
			
			}else if( event.type == LoadEvent.FAIL ){
				Test.fail( this , event.error );
			}
		}
		
	}
}