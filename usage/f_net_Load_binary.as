package
{
	import f.net.Load;
	
	import flash.display.Loader;
	import flash.display.Sprite;

	public class f_net_Load_binary extends Sprite
	{
		public function f_net_Load_binary():void
		{
			Load.binary( 'http://onflex.org/f/Load/test.png' , this.loadBinary , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadBinary( event:Object ):void
		{
			if( event.type == Load.COMPLETE ){
				trace( ' < loadMovie COMPLETE: ' );
				var ld:Loader = new Loader()
					ld.loadBytes( event.data );
				this.addChild( ld );
				
			}else if( event.type == Load.PROGRESS ){
				trace( ' < loadMovie PROGRESS: ' + event.percent );	
			}
		}
		
	}
}