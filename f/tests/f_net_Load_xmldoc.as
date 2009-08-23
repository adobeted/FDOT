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
			Test.register( this );
			Load.xmldoc( 'http://onflex.org/f/Load/test.xml' , loadXML , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadXML( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.SUCCESS ){
				if( XMLDocument( event.data ).docTypeDecl == '<!DOCTYPE PLAY SYSTEM "play.dtd">' ){
					trace( ' < SUCCESS' );
					Test.pass( this );
				}else{
					Test.fail( this , 'INVALID DATA TEST' );
				}
				
			}else if( event.type == LoadEvent.PROGRESS ){
				//trace( ' < PROGRESS: ' + event.percent );	
			
			}else if ( event.type == LoadEvent.OPEN ){
				trace( ' < OPEN: ' );	
			
			}else if ( event.type == LoadEvent.CLOSE ){
				trace( ' < CLOSE: ' );
				
			}else if ( event.type == LoadEvent.INIT ){
				trace( ' < INIT: ' );
				
			}else if( event.type == LoadEvent.FAIL ){
				Test.fail( this , event.error );
			}
		}
	}
}