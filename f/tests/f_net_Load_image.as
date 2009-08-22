package f.tests
{
	import flash.display.Sprite;
	import f.net.Load;
	import f.events.LoadEvent;

	public class f_net_Load_image extends Sprite
	{
		public function f_net_Load_image():void
		{
			Load.image( 'http://onflex.org/f/Load/test.png' , this.loadImage , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadImage( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.SUCCESS ){
				trace( ' < loadMovie SUCCESS: ' );
				this.addChild( event.data );
				
			}else if( event.type == LoadEvent.PROGRESS ){
				trace( ' < loadMovie PROGRESS: ' + event.percent );	
			
			}else if( event.type == LoadEvent.FAIL ){
				throw new Error( 'FAIL-FAIL-FAIL' + event.status );
			}
		}
		
	}
}