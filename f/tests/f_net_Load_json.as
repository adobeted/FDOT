package f.tests
{
	import f.data.format.json.*;
	import f.events.LoadEvent;
	import f.net.Load;
	
	import flash.display.Sprite;

	public class f_net_Load_json extends Sprite
	{
		public function f_net_Load_json():void
		{
			Test.register( this );
			Load.json( 'http://onflex.org/f/Load/test.json' , this.loadJson , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadJson( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.SUCCESS ){
				if( event.data.glossary.GlossDiv.GlossList.GlossEntry.GlossTerm == 'Standard Generalized Markup Language' ){
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