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
			Load.json( 'http://onflex.org/f/Load/test.json' , this.loadJson , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadJson( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.SUCCESS ){
				trace( ' < Load.json SUCCESS: ' + event.data.glossary.GlossDiv.GlossList.GlossEntry.GlossTerm );
			
			}else if( event.type == LoadEvent.PROGRESS ){
				trace( ' < Load.json PROGRESS: ' + event.percent );
			
			}else if( event.type == LoadEvent.FAIL ){
				throw new Error( 'FAIL-FAIL-FAIL' + event.status );
			}
		}
	}
}