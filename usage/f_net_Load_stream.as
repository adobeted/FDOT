package
{
	import f.net.Load;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLStream;

	public class f_net_Load_stream extends Sprite
	{
		public function f_net_Load_stream():void
		{
			Load.stream( 'http://onflex.org/f/Load/test.png' , loadStream , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadStream( event:Object ):void
		{
			if( event.type == Load.COMPLETE ){
				trace( ' < Load.stream COMPLETE: ' );
				var load:Loader = new Loader()
				load.loadBytes( event.data );
				addChild( load );
				
			}else if( event.type == Load.PROGRESS ){
				trace( ' < Load.stream PROGRESS: ' + event.percent );	
				trace( URLStream(event.stream).bytesAvailable );
			}
		}
		
	}
}