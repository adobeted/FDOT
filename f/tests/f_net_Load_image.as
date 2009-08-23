package f.tests
{
	import flash.display.Sprite;
	import f.net.Load;
	import f.events.LoadEvent;

	public class f_net_Load_image extends Sprite
	{
		public function f_net_Load_image():void
		{
			Test.register( this );
			Load.image( 'http://onflex.org/f/Load/test.png' , this.loadImage , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadImage( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.SUCCESS ){
				trace( ' < SUCCESS: ' );
				this.addChild( event.data );
				Test.pass( this );
				
			}else if( event.type == LoadEvent.PROGRESS ){
				trace( ' < PROGRESS: ' + event.percent );	
			
			}else if( event.type == LoadEvent.FAIL ){
				Test.fail( this , event.error );
			}
		}
		
	}
}