package
{
	import f.net.Load;
	
	import flash.display.Loader;
	import flash.display.Sprite;

	public class f_net_Load_querystring extends Sprite
	{
		public function f_net_Load_querystring():void
		{
			Load.querystring( 'http://onflex.org/f/Load/test.query' , this.loadQuerystring , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadQuerystring( event:Object ):void
		{
			if( event.type == Load.COMPLETE ){
				trace( ' < loadMovie COMPLETE: ' + event.data.field2 );			
			}else if( event.type == Load.PROGRESS ){
				trace( ' < loadMovie PROGRESS: ' + event.percent );	
			}
		}
		
	}
}