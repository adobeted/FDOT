package
{
	import f.net.Load;
	import f.format.json.*;
	import flash.display.Sprite;

	public class f_net_Load_json extends Sprite
	{
		public function f_net_Load_json():void
		{
			Load.json( 'http://onflex.org/f/Load/test.json' , this.loadJson , { method:'post', data:{ a:12345 } } );
		}
		
		public function loadJson( event:Object ):void
		{
			if( event.type == Load.COMPLETE ){
				trace( ' < Load.json COMPLETE: ' + event.data.glossary.GlossDiv.GlossList.GlossEntry.GlossTerm );
			}else if( event.type == Load.PROGRESS ){
				trace( ' < Load.json PROGRESS: ' + event.percent );
			}
		}
	}
}