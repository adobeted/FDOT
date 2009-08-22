package
{
	import flash.display.Sprite;
	import f.net.Load;

	public class f_net_Load_image extends Sprite
	{
		public function f_net_Load_image():void
		{
			Load.image( 'http://onflex.org/f/Load/test.png' , this.loadImage , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadImage( event:Object ):void
		{
			if( event.type == Load.COMPLETE ){
				trace( ' < loadMovie COMPLETE: ' );
				this.addChild( event.data );
				
			}else if( event.type == Load.PROGRESS ){
				trace( ' < loadMovie PROGRESS: ' + event.percent );	
			}
		}
		
	}
}