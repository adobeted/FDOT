package f.tests
{
	import f.events.LoadEvent;
	import f.net.Load;
	
	import flash.display.Sprite;

	public class f_net_Load_text extends Sprite
	{
		public function f_net_Load_text():void
		{
			Load.text( 'http://onflex.org/f/Load/test.txt' , this.loadText , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadText( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.SUCCESS ){
				trace( ' < loadMovie COMPLETE: ' + event.data );			
			
			}else if( event.type == LoadEvent.PROGRESS ){
				trace( ' < loadMovie PROGRESS: ' + event.percent );	
			
			}else if( event.type == LoadEvent.FAIL ){
				throw new Error( 'FAIL-FAIL-FAIL' + event.status );
			}
		}
		
	}
}