package f.tests
{
	import f.events.LoadEvent;
	import f.net.Load;
	
	import flash.display.Sprite;

	public class f_net_Load_e4x extends Sprite
	{
		public function f_net_Load_e4x():void
		{
			Test.register( this );
			Load.e4x( 'http://onflex.org/f/Load/test.xml' , loadXML , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadXML( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.SUCCESS ){
				if( event.data.TITLE == 'The Tragedy of Hamlet, Prince of Denmark' ){
					trace( ' < SUCCESS');
					Test.pass( this );
				}else{
					Test.fail( this , 'INVALID DATA TEST' );
				}
				
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