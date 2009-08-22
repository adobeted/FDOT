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
// f.net.Message
//
// class provides static methods for message routing
//
//		//add a method by name
// 		Message.add( this.method, 'simple' );  
//
//		//send messages to all names
// 		Message.send( {foo:'bar'} ); 	
//	
//		//send messages to a name	
// 		Message.send( {foo:'bar'} , 'simple' );
//	
//		//remove name
// 		Message.remove( 'simple' );
// 
//		//remove all
// 		Message.remove();  
//
// Contributors: Ted Patrick
//

package f.net
{
	import f.data.ObjectStore;
	import flash.utils.Dictionary;
		

	public class Message
	{
		
		//listeners object
		private static var listeners:ObjectStore = null;
		
		
		//send message to all listeners
		public static function send( obj:Object , name:String=null ):Boolean
		{
			var target:Object;
			if( Message.listeners == null ) return false;
			target = Message.listeners.read( name );
			
			//fire one
			if( target is Function ){
				target( obj );
			//walk and fire
			}else if( target is Dictionary ){
				Message.walkSend( target , obj );
			}
			return true;
		}
		
		private static function walkSend( target:Object , obj:Object ):void
		{
			var i:String;
			for( i in target ){
				if( target[ i ] is Dictionary ){
					Message.walkSend( target[ i ] , obj );
				}else if( target[ i ] is Function ){
					target[ i ]( obj );
				}
			}
		}
				
		//add a listener by name
		public static function add( object:Object , name:String ):Boolean
		{
			if( Message.listeners == null ) Message.listeners = new ObjectStore();
			return Message.listeners.write( name , object );
		}
		
		//does a listener exist
		public static function exists( name:String ):Boolean
		{
			if( Message.listeners == null ) Message.listeners = new ObjectStore();
			return Message.listeners.exists( name );
		}
		
		//remove a listener
		public static function remove( name:String = null ):Boolean
		{
			if( Message.listeners == null ) return false;
			return Message.listeners.remove( name );
		}
		
	}
}