package f.tests
{
	import f.events.LoadEvent;
	import f.net.Load;
	
	import flash.display.Loader;
	import flash.display.Sprite;

	public class f_net_Load_binary extends Sprite
	{
		public function f_net_Load_binary():void
		{
			Load.binary( 'http://onflex.org/f/Load/test.png' , this.loadBinary , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadBinary( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.SUCCESS ){
				trace( ' < loadMovie SUCCESS: ' );
				var ld:Loader = new Loader()
					ld.loadBytes( event.data );
				this.addChild( ld );
				
			}else if( event.type == LoadEvent.PROGRESS ){
				trace( ' < loadMovie PROGRESS: ' + event.percent );	
			
			}else if( event.type == LoadEvent.FAIL ){
				throw new Error( 'FAIL-FAIL-FAIL' + event.status );
			}
			
		}
		
	}
}