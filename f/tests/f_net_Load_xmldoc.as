package f.tests
{
	import f.events.LoadEvent;
	import f.net.Load;
	import flash.xml.XMLDocument;
	
	import flash.display.Sprite;

	public class f_net_Load_xmldoc extends Sprite
	{
		public function f_net_Load_xmldoc():void
		{
			Load.xmldoc( 'http://onflex.org/f/Load/test.xml' , loadXML , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadXML( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.SUCCESS ){
				trace( ' < loadMovie COMPLETE: ' + XMLDocument(event.data).toString() );
				
			}else if( event.type == LoadEvent.PROGRESS ){
				trace( ' < loadMovie PROGRESS: ' + event.percent );	
			
			}else if( event.type == LoadEvent.FAIL ){
				throw new Error( 'FAIL-FAIL-FAIL' + event.status );
			}
		}
		
	}
}