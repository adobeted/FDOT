package f.tests
{
	import f.events.LoadEvent;
	import f.net.Load;
	
	import flash.display.Sprite;

	public class f_net_Load_e4x extends Sprite
	{
		public function f_net_Load_e4x():void
		{
			Load.e4x( 'http://onflex.org/f/Load/test.xml' , loadXML , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadXML( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.SUCCESS ){
				trace( ' < loadMovie COMPLETE: ' + event.data.TITLE );
				
			}else if( event.type == LoadEvent.PROGRESS ){
				trace( ' < loadMovie PROGRESS: ' + event.percent );	
			
			}else if( event.type == LoadEvent.FAIL ){
				throw new Error( 'FAIL-FAIL-FAIL' + event.status );
			}
		}
		
	}
}