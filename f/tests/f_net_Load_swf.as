package f.tests
{
	import f.events.LoadEvent;
	import f.net.Load;
	
	import flash.display.Sprite;

	public class f_net_Load_swf extends Sprite
	{
		public function f_net_Load_swf()
		{
			Test.register( this );
			Load.swf( 'http://onflex.org/f/Load/test.swf' , this.loadSwf , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadSwf( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.SUCCESS ){
				trace( ' < SUCCESS: ' );
				this.addChild( event.data );
				Test.pass( this );
				
			}else if( event.type == LoadEvent.PROGRESS ){
				//trace( ' < PROGRESS: ' + event.percent );	
			
			}else if ( event.type == LoadEvent.OPEN ){
				trace( ' < OPEN: ' );	
			
			}else if ( event.type == LoadEvent.CLOSE ){
				trace( ' < CLOSE: ' );
				
			}else if ( event.type == LoadEvent.INIT ){
				trace( ' < INIT: ' );
				
			}else if( event.type == LoadEvent.FAIL ){
				Test.fail( this , event.error );
			}
		}
	}
}