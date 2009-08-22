package
{
	import flash.display.Sprite;
	import f.net.Load;

	public class f_net_Load_swf extends Sprite
	{
		public function f_net_Load_swf()
		{
			Load.swf( 'http://onflex.org/f/Load/test.swf' , this.loadSwf , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadSwf( event:Object ):void
		{
			if( event.type == Load.COMPLETE ){
				trace( ' < Load.swf COMPLETE: ' );
				this.addChild( event.data );
				
			}else if( event.type == Load.PROGRESS ){
				trace( ' < Load.swf PROGRESS: ' + event.percent );	
			}
		}
	}
}