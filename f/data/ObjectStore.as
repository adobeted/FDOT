/*
  Copyright (c) 2009, Adobe Systems Incorporated
  All rights reserved.

  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of Adobe Systems Incorporated nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
//
// f.data.ObjectStore
//
// class provides object storage by strings using dot notation
//
//		//create an ObjectStore Instance
// 		var os:ObjectStore = new ObjectStore();
//
//		//write a value
// 		os.write( 'root.window2.title', 'Hello World' );
//	
//		//read a value
// 		os.read( 'root.window2.title' );   //Hello World
//	
//		//test exists
// 		os.exists( 'root.window2.title' );   //true
// 
//		//remove value
// 		os.remove( 'root.window2.title' );
//		
//		//remove all
// 		os.remove();
//
//
// Contributors: Ted Patrick, Patrick Denny
//

package f.data
{
	import flash.utils.Dictionary;

	public class ObjectStore
	{
		
		//storage
		private var storage:Dictionary;
		
		//constructor
		public function ObjectStore()
		{
			this.storage = new Dictionary();
		}
		
		//does a proerty exist?
		public function exists( name:String ):Boolean
		{
			if( name == null) return false;
			var args:Array = name.split( '.' );
			var i:int;
			var base:Object = this.storage
			var length:int = args.length;
			for( i=0 ; i < length ; i++)
			{
				if( base.hasOwnProperty( args[i] ) ){
					base = base[ args[ i ] ];
				}else{
					return false; 
				}
			}
			return true;
		}
		
		//read a value
		public function read( name:String = null ):Object
		{
			if( name == null) return this.storage;
			var args:Array = name.split( '.' );
			var i:int;
			var base:Object = this.storage
			var length:int = args.length;
			for( i=0 ; i < length ; i++)
			{
				if( base.hasOwnProperty( args[i] ) ){
					base = base[ args[ i ] ];
				}else{
					return null; 
				}
			}
			return base;
		}
		
		//write a value
		public function write( name:String , value:Object ):Boolean
		{
			//read down to parent of name
			var args:Array = name.split( '.' );
			var i:int;
			var base:Object = this.storage
			var length:int = args.length;
			for( i=0 ; i < length-1 ; i++)
			{
				// if value is null, create it
				if( base.hasOwnProperty( args[ i ] ) ){
					//map deeper in
					base = base[ args[ i ] ];
				}else{
					//create property
					base = base[ args[ i ] ] = new Dictionary();					
				}
			}
			//delete if something exists there
			if( base.hasOwnProperty( args[ length-1 ] ) ){
				delete base[ args[ length-1 ] ];
			}
			base[ args[ length - 1 ] ] = value;
			return true;
		
		}
		
		//remove a value
		public function remove( name:String = null ):Boolean
		{
			//delete name
			//when name is passed, drill in and delete the node
			if( name ){
				//read down to parent of name
				var args:Array = name.split('.');
				var i:int;
				var base:Object = this.storage;
				var length:int = args.length;
				for( i=0 ; i < length-1 ; i++)
				{
					if(  base.hasOwnProperty( args[ i ] ) ){
						//redefine base picking next item within. 
						base = base[ args[ i ] ];
					}else{
						//return false given no deleltion
						return false;						
					}
				}
				//delete node
				delete base[ args[ args.length - 1 ] ];
				//return true that we deleted something
				return true;
				
			//delete all.
			//loop across all obj in root and delete them all.
			}else{
				this.storage = new Dictionary();
				return true
			}
		}
	}
}