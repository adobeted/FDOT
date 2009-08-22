package
{
	import flash.display.Sprite;
	import f.net.Load;

	public class f_net_Load_xml extends Sprite
	{
		public function f_net_Load_xml():void
		{
			Load.xml( 'http://onflex.org/f/Load/test.xml' , loadXML , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadXML( event:Object ):void
		{
			if( event.type == Load.COMPLETE ){
				trace( ' < loadMovie COMPLETE: ' + event.data.TITLE );
				
			}else if( event.type == Load.PROGRESS ){
				trace( ' < loadMovie PROGRESS: ' + event.percent );	
			}
		}
		
	}
}