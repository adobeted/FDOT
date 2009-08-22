package
{
	import f.net.Load;
	
	import flash.display.Loader;
	import flash.display.Sprite;

	public class f_net_Load_text extends Sprite
	{
		public function f_net_Load_text():void
		{
			Load.text( 'http://onflex.org/f/Load/test.txt' , this.loadText , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadText( event:Object ):void
		{
			if( event.type == Load.COMPLETE ){
				trace( ' < loadMovie COMPLETE: ' + event.data );			
			}else if( event.type == Load.PROGRESS ){
				trace( ' < loadMovie PROGRESS: ' + event.percent );	
			}
		}
		
	}
}