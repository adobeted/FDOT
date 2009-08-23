package f.tests
{
	import f.events.LoadEvent;
	import f.net.Load;
	import flash.display.Loader;
	import flash.display.Sprite;

	public class f_net_Load_amf extends Sprite
	{
		public function f_net_Load_amf():void
		{
			Test.register( this );
			Load.amf( 'http://onflex.org/f/Load/test.amf' , this.loadBinary , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadBinary( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.SUCCESS ){
				if( event.data.fname == 'Theodore' ){
					Test.pass( this );
				}else{
					Test.fail( this , 'INVALID DATA TEST' );
				}
				trace( ' < SUCCESS' );
				
			}else if( event.type == LoadEvent.PROGRESS ){
				//trace( ' < PROGRESS: ' + event.percent );	
			
			}else if ( event.type == LoadEvent.OPEN ){
				trace( ' < OPEN' );	
			
			}else if ( event.type == LoadEvent.CLOSE ){
				trace( ' < CLOSE' );
				
			}else if ( event.type == LoadEvent.INIT ){
				trace( ' < INIT' );
						
			}else if( event.type == LoadEvent.FAIL ){
				trace( ' < FAIL' );
				Test.fail( this , event.error );
			}
			
		}
		
	}
}