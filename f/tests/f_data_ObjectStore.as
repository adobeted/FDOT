package f.tests
{
	import f.data.ObjectStore;
	
	import flash.display.Sprite;

	public class f_data_ObjectStore extends Sprite
	{
		public function f_data_ObjectStore()
		{
			var os:ObjectStore = new ObjectStore();
			//path creation is auto
			//set properties
			
			trace( os.exists( 'root.ted.firstName' ) );
			os.write( 'root.ted.firstName', 'Theodore' );
			
			trace( os.exists( 'root.ted.firstName' ) );
			os.write( 'root.ted.lastName', 'Theodore' );
			os.write( 'root.ted.age', 37 );
			os.write( 'root.ted.homeOwner', true );
			
			os.write( 'root.linda.firstName', 'Linda' );
			os.write( 'root.linda.lastName', 'Patrick' );
			os.write( 'root.linda.age', 37.0001 );
			os.write( 'root.linda.homeOwner', true );
			
			//inner reference support
			os.write( 'root.linda.spouse', os.read( 'root.ted' ) );
			os.write( 'root.ted.spouse', os.read( 'root.linda' ) );
			
			trace( os.read( 'root.linda.age' ) > os.read( 'root.ted.age' ) ) ;
			trace( os.read( 'root.ted.age' ) ) ;
			trace( os.read( 'root.ted.spouse.firstName' ) ) ;
			trace( os.exists( 'root.ted.age' ) );
			trace( os.remove( 'root.ted.age' ) );
			trace( os.exists( 'root.ted.age' ) );
			
			
		}
		
	}
}