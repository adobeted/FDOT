package f.tests
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class Test
	{
		private static const TYPE_FAIL:String = "FAIL";
		private static const TYPE_PASS:String = "PASS";
		private static const TYPE_INCOMPLETE:String = "INCOMPLETE";
		
		private static var storage:Dictionary;
		public static var instantFail:Boolean = true;
		
		public static function register( obj:Object ):void
		{
			if( ! storage ) Test.storage = new Dictionary();
			Test.storage[ getQualifiedClassName( obj ) ] = {};
			Test.storage[ getQualifiedClassName( obj ) ].status = Test.TYPE_INCOMPLETE;
		}
		
		public static function pass( obj:Object ):void
		{
			Test.storage[ getQualifiedClassName( obj ) ].status = Test.TYPE_PASS;
			if( Test.isComplete() ) Test.report();
		}
		
		public static function fail( obj:Object , why:String ):void
		{
			Test.storage[ getQualifiedClassName( obj ) ].status = Test.TYPE_FAIL;
			Test.storage[ getQualifiedClassName( obj ) ].why = why;
			if( Test.instantFail ){
				Test.report();
				throw new Error( 'TEST INSTANT FAIL: ' + why );
			} 
			if( Test.isComplete() ) Test.report();
		}
		
		public static function isComplete():Boolean
		{
			var i:String
			for( i in Test.storage ){
				if( Test.storage[ i ].status == Test.TYPE_INCOMPLETE ) return false;
			}
			return true;
		}
		
		public static function report():void
		{
			trace( '--------------------------------------------' );
			trace( ' TEST REPORT ' );
			trace( '--------------------------------------------' );
			var i:String
			for( i in Test.storage ){
				if( Test.storage[ i ].status == Test.TYPE_PASS ){
					trace( '  +++  PASS       TEST: ' + i );
				}else if( Test.storage[ i ].status == Test.TYPE_FAIL ){
					trace( '  ---  FAIL       TEST: ' + i + '  WHY: ' + Test.storage[ i ].why );
				}else if( Test.storage[ i ].status == Test.TYPE_INCOMPLETE ){
					trace( '  ???  INCOMPLETE TEST: ' + i );
				}
			}	
			trace( '--------------------------------------------' );
		}
	}
}