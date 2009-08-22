package f.tests
{
	import f.events.LoadEvent;
	import f.net.Load;
	
	import flash.display.Sprite;

	public class f_net_Load_swf extends Sprite
	{
		public function f_net_Load_swf()
		{
			Load.swf( 'http://onflex.org/f/Load/test.swf' , this.loadSwf , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadSwf( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.SUCCESS ){
				trace( ' < Load.swf SUCCESS: ' );
				this.addChild( event.data );
				
			}else if( event.type == LoadEvent.PROGRESS ){
				trace( ' < Load.swf PROGRESS: ' + event.percent );	
			
			}else if( event.type == LoadEvent.FAIL ){
				throw new Error( 'FAIL-FAIL-FAIL' + event.status );
			}
		}
	}
}