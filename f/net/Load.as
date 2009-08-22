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
// f.net.Load
//
// class provides static methods for loading external data
//
//		//load swf
// 		Load.swf( 'http://onflex.org/f/Load/test.swf' );
//	
//		//load image
// 		Load.image( 'http://onflex.org/f/Load/test.png' );
//
//		//load binary
// 		Load.binary( 'http://onflex.org/f/Load/test.png' );
//
//		//load stream
// 		Load.stream( 'http://onflex.org/f/Load/test.png' );
//
//		//load xml
// 		Load.xml( 'http://onflex.org/f/Load/test.xml' );
//	
//		//load json
// 		Load.json( 'http://onflex.org/f/Load/test.json' );
//
//		//load text
// 		Load.text( 'http://onflex.org/f/Load/test.xml' );
//
//		//load querystring
// 		Load.querystring( 'http://onflex.org/f/Load/test.xml' );
//
//
// Contributors: Ted Patrick
//

package f.net
{
	import f.data.format.json.*;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLStream;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class Load
	{
		
		public static const OPEN:String = "load.open";
		public static const CLOSE:String = "load.close";
		public static const PROGRESS:String = "load.progress";
		public static const COMPLETE:String = "load.complete";
		public static const HTTPSTATUS:String = "load.httpstatus";
		public static const IOERROR:String = "load.ioerror";
		public static const SECURITYERROR:String = "load.securityerror";
		public static const INIT:String = "load.init";
		private static var requests:Dictionary;
		
		//sample event handler
		public static function sampleSwitchEventHandler( event:Object ):void
		{
			switch ( event.type ){
				case Load.CLOSE:
					trace( getTimer() + ' ' + Load.CLOSE );
					break;
				case Load.OPEN:
					trace( getTimer() + ' ' + Load.OPEN );
					break;
				case Load.COMPLETE:
					trace( getTimer() + ' ' + Load.COMPLETE );
					break;
				case Load.HTTPSTATUS:
					trace( getTimer() + ' ' + Load.HTTPSTATUS );
					break;
				case Load.INIT:
					trace( getTimer() + ' ' + Load.INIT );
					break;
				case Load.IOERROR:
					trace( getTimer() + ' ' + Load.IOERROR );
					break;
				case Load.PROGRESS:
					trace( getTimer() + ' ' + Load.PROGRESS + ' ' + event.bytesLoaded );
					break;
				case Load.SECURITYERROR:
					trace( getTimer() + ' ' + Load.SECURITYERROR );
					break;
				default:
					trace( getTimer() + ' default case fired in error' );
					break;
			}
		}
		
		//sample event handler
		public static function sampleEventHandler( event:Object ):void
		{
			if( event.type == Load.CLOSE ){
				trace( getTimer() + ' ' + Load.CLOSE );
			}else if( event.type == Load.OPEN ){
				trace( getTimer() + ' ' + Load.OPEN );
			}else if( event.type == Load.COMPLETE ){
				trace( getTimer() + ' ' + Load.COMPLETE );
			}else if( event.type == Load.HTTPSTATUS ){
				trace( getTimer() + ' ' + Load.HTTPSTATUS );
			}else if( event.type == Load.INIT ){
				trace( getTimer() + ' ' + Load.INIT );
			}else if( event.type == Load.IOERROR ){
				trace( getTimer() + ' ' + Load.IOERROR );
			}else if( event.type == Load.PROGRESS ){
				trace( getTimer() + ' ' + Load.PROGRESS + ' ' + event.bytesLoaded );
			}else if( event.type == Load.SECURITYERROR ){
				trace( getTimer() + ' ' + Load.SECURITYERROR );
			}else{
				trace( getTimer() + ' default case fired in error' );			
			}
		}
		
		public static function swf( url:String , handler:Function , parameters:Object=null ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = "swf";
			Load.loadMovie( url , handler , parameters );		
		}
		
		public static function image( url:String , handler:Function , parameters:Object=null  ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = "image";
			Load.loadMovie( url , handler , parameters );		
		}
		
		public static function binary( url:String , handler:Function , parameters:Object=null ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = "binary";
			Load.loadStream( url , handler , parameters );		
		}
		
		public static function stream( url:String , handler:Function , parameters:Object=null ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = "stream";
			Load.loadStream( url , handler , parameters );		
		}
		
		public static function querystring( url:String , handler:Function , parameters:Object=null ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = "querystring";
			Load.loadData( url , handler , parameters );		
		}
		
		public static function text( url:String , handler:Function , parameters:Object=null  ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = "text";
			return Load.loadData( url , handler , parameters );		
		}
		
		public static function json( url:String , handler:Function , parameters:Object=null ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = "json";
			Load.loadData( url , handler , parameters );		
		}
		
		public static function xml( url:String , handler:Function , parameters:Object=null ):void
		{
			if( parameters == null ){
				parameters = {};
			} 
			parameters.resultFormat = "xml";
			Load.loadData( url , handler , parameters );		
		}
		
		
		
		
        // LOADDATA
		//---------------------------
		
		//handles loading ASCII data
		private static function loadData( url:String , handler:Function , parameters:Object=null ):void
		{
			Load.init();
			var loader:URLLoader = new URLLoader();
            
            //configure listeners
            loader.addEventListener( Event.COMPLETE , Load.loadDataComplete );
            loader.addEventListener( Event.OPEN , Load.loadDataOpen );
            loader.addEventListener( ProgressEvent.PROGRESS , Load.loadDataProgress );
            loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR , Load.loadDataSecurityError );
            loader.addEventListener( HTTPStatusEvent.HTTP_STATUS , Load.loadDataHttpStatus );
            loader.addEventListener( IOErrorEvent.IO_ERROR , Load.loadDataIoError );
            
            //store request
            Load.requests[ loader ] = prepareRequest( url, handler, parameters );
            
            try {
                loader.load( Load.requests[ loader ].request );
            } catch ( error:Error ) {
                trace("Unable to load requested document.");
            }
            
		}

        private static function loadDataComplete(event:Event):void {
            var loader:URLLoader = URLLoader( event.target );
            var resultFormat:String = Load.requests[ loader ].resultFormat;
            var message:Object;
            if( resultFormat == 'xml'){
            	//trace( 'resultFormat == xml');
            	message = { type:Load.COMPLETE , data: new XML( loader.data ) , loader:loader }; 
            }else if( resultFormat == 'json'){
            	//trace( 'resultFormat == json');
            	message = { type:Load.COMPLETE , data:JSON.decode( loader.data ) , loader:loader }; 
            }else if( resultFormat == 'text'){
            	//trace( 'resultFormat == text');
            	message = { type:Load.COMPLETE , data:loader.data , loader:loader }; 
            }else if( resultFormat == 'querystring'){
            	//trace( 'resultFormat == querystring');
            	message = { type:Load.COMPLETE , data: new URLVariables( loader.data ) , loader:loader }; 
            }else{
            	//default
            	message = { type:Load.COMPLETE , data:loader.data , loader:loader };
            }
            Load.processMessage( loader , message );
			
			//clean up
			delete Load.requests[ loader ];
			
            loader.removeEventListener( Event.COMPLETE , loadDataComplete );
            loader.removeEventListener( Event.OPEN , loadDataOpen );
            loader.removeEventListener( ProgressEvent.PROGRESS , loadDataProgress );
            loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , loadDataSecurityError );
            loader.removeEventListener( HTTPStatusEvent.HTTP_STATUS , loadDataHttpStatus );
            loader.removeEventListener( IOErrorEvent.IO_ERROR , loadDataIoError );
		}

        private static function loadDataOpen( event:Event ):void {
            var loader:URLLoader = URLLoader( event.target );
            var message:Object = { type:Load.OPEN , loader:loader };
			Load.processMessage( loader , message );
        }

        private static function loadDataProgress( event:ProgressEvent ):void {
            var loader:URLLoader = URLLoader( event.target );
            var message:Object = {}
            message.type = Load.PROGRESS
            message.percent = Number( event.bytesLoaded / event.bytesTotal * 100).toPrecision( 4 );
            if( event.bytesLoaded ) message.bytesLoaded = event.bytesLoaded;
            if( event.bytesTotal ) message.bytesTotal = event.bytesTotal;
            message.loader = loader;
			Load.processMessage( loader , message );
		 }

        private static function loadDataSecurityError(event:SecurityErrorEvent):void {
            var loader:URLLoader = URLLoader( event.target );
            var message:Object = { type:Load.SECURITYERROR , loader:loader };
			Load.processMessage( loader , message );
        }

        private static function loadDataHttpStatus(event:HTTPStatusEvent):void {
            var loader:URLLoader = URLLoader( event.target );
            var message:Object = { type:Load.HTTPSTATUS , loader:loader };
			Load.processMessage( loader , message );
        }

        private static function loadDataIoError(event:IOErrorEvent):void {
            var loader:URLLoader = URLLoader( event.target );
            var message:Object = { type:Load.IOERROR , loader:loader };
			Load.processMessage( loader , message );
        }
		
		
		
		// LOADSTREAM
		//---------------------------
		
		//handles loading ASCII data
		private static function loadStream( url:String , handler:Function , parameters:Object=null ):void
		{
			Load.init();
			var loader:URLStream = new URLStream();
            
            //configure listeners
            loader.addEventListener( Event.COMPLETE , Load.loadStreamComplete );
            loader.addEventListener( Event.OPEN , Load.loadStreamOpen );
            loader.addEventListener( ProgressEvent.PROGRESS , Load.loadStreamProgress );
            loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR , Load.loadStreamSecurityError );
            loader.addEventListener( HTTPStatusEvent.HTTP_STATUS , Load.loadStreamHttpStatus );
            loader.addEventListener( IOErrorEvent.IO_ERROR , Load.loadStreamIoError );
            
            //store request
            Load.requests[ loader ] = prepareRequest( url, handler, parameters );
            
            try {
                loader.load( Load.requests[ loader ].request );
            } catch ( error:Error ) {
                trace("Unable to load requested document.");
            }
		}

        private static function loadStreamComplete(event:Event):void {
            var loader:URLStream = URLStream( event.target );
            var bytesOut:ByteArray = new ByteArray();
            loader.readBytes( bytesOut );
 			var message:Object = { type:Load.COMPLETE , data:bytesOut , loader:loader };
			Load.processMessage( loader , message );
			
			//clean up
			delete Load.requests[ loader ];
			
            loader.removeEventListener( Event.COMPLETE , loadDataComplete );
            loader.removeEventListener( Event.OPEN , loadDataOpen );
            loader.removeEventListener( ProgressEvent.PROGRESS , loadDataProgress );
            loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , loadDataSecurityError );
            loader.removeEventListener( HTTPStatusEvent.HTTP_STATUS , loadDataHttpStatus );
            loader.removeEventListener( IOErrorEvent.IO_ERROR , loadDataIoError );
		}

        private static function loadStreamOpen( event:Event ):void {
            var loader:URLStream = URLStream( event.target );
            var message:Object = { type:Load.OPEN , loader:loader };
			Load.processMessage( loader , message );
        }

        private static function loadStreamProgress( event:ProgressEvent ):void {
            var loader:URLStream = URLStream( event.target );
             var message:Object = {}
            message.type = Load.PROGRESS
            message.percent = Number( event.bytesLoaded / event.bytesTotal * 100 ).toPrecision( 4 );
            if( event.bytesLoaded ) message.bytesLoaded = event.bytesLoaded;
            if( event.bytesTotal ) message.bytesTotal = event.bytesTotal;
            message.stream = loader;
			Load.processMessage( loader , message );
		 }

        private static function loadStreamSecurityError( event:SecurityErrorEvent ):void {
            var loader:URLStream = URLStream( event.target );
            var message:Object = { type:Load.SECURITYERROR , loader:loader };
			Load.processMessage( loader , message );
        }

        private static function loadStreamHttpStatus( event:HTTPStatusEvent ):void {
            var loader:URLStream = URLStream( event.target );
            var message:Object = { type:Load.HTTPSTATUS , loader:loader };
			Load.processMessage( loader , message );
        }

        private static function loadStreamIoError( event:IOErrorEvent ):void {
            var loader:URLStream = URLStream( event.target );
            var message:Object = { type:Load.IOERROR , loader:loader };
			Load.processMessage( loader , message );
        }
		
		
		
		
		// LOADMOVIE
		//---------------------------
		
		//handles loading DisplayObjects
		private static function loadMovie( url:String , handler:Function , parameters:Object=null ):void
		{
			Load.init();	
			
			var loader:Loader = new Loader();
            
            //configure listeners
            loader.contentLoaderInfo.addEventListener( Event.COMPLETE , Load.loadMovieComplete );
            loader.contentLoaderInfo.addEventListener( Event.OPEN , Load.loadMovieOpen );
            loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS , Load.loadMovieProgress );
            loader.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR , Load.loadMovieSecurityError );
            loader.contentLoaderInfo.addEventListener( HTTPStatusEvent.HTTP_STATUS , Load.loadMovieHttpStatus );
            loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR , Load.loadMovieIoError );
            loader.contentLoaderInfo.addEventListener( Event.INIT , Load.loadMovieInit );
            
           	//store request
            parameters = Load.requests[ loader.contentLoaderInfo ] = prepareRequest( url, handler, parameters );
            parameters.contentLoaderInfo = loader.contentLoaderInfo;
            parameters.loader = loader;
            
            try {
                loader.load( parameters.request );
            } catch ( error:Error ) {
                trace("Unable to load requested document.");
            }
		}
		
		//MOVIE EVENTS
        private static function loadMovieComplete( event:Event ):void {
            var contentLoaderInfo:LoaderInfo = LoaderInfo( event.target );
 			var message:Object = { type:Load.COMPLETE , loaderInfo:contentLoaderInfo , data:contentLoaderInfo.loader };
			Load.processMessage( contentLoaderInfo , message );
			
			//clean up
			delete Load.requests[ contentLoaderInfo ];
			
            contentLoaderInfo.removeEventListener( Event.COMPLETE , Load.loadMovieComplete );
            contentLoaderInfo.removeEventListener( Event.OPEN , Load.loadMovieOpen );
            contentLoaderInfo.removeEventListener( Event.INIT , Load.loadMovieInit );
            contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS , Load.loadMovieProgress );
            contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , Load.loadMovieSecurityError );
            contentLoaderInfo.removeEventListener( HTTPStatusEvent.HTTP_STATUS , Load.loadMovieHttpStatus );
            contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR , Load.loadMovieIoError );
		}
		
		private static function loadMovieOpen( event:Event ):void {
            var loader:LoaderInfo = LoaderInfo( event.target );
            var message:Object = { type:Load.OPEN , loaderInfo:loader };
			Load.processMessage( loader , message );
        }
        
        private static function loadMovieInit(event:Event):void {
            var loader:LoaderInfo = LoaderInfo( event.target );
            var message:Object = { type:Load.INIT , loaderInfo:loader };
			Load.processMessage( loader , message );
        }

        private static function loadMovieProgress( event:ProgressEvent ):void {
            var loader:LoaderInfo = LoaderInfo( event.target );
            var message:Object;
            //not sure if 0 is correcto
            if( loader.bytesTotal != 0 ){
	            message = { type:Load.PROGRESS , 
	            			percent:Number( loader.bytesLoaded / loader.bytesTotal * 100 ).toPrecision(4) , 
	            			bytesLoaded:loader.bytesLoaded, bytesTotal:loader.bytesTotal , 
	            			loaderInfo:loader };
            }else{
            	message = { type:Load.PROGRESS , bytesLoaded:loader.bytesLoaded , loaderInfo:loader };
            }
            Load.processMessage( loader , message );
		}

        private static function loadMovieSecurityError( event:SecurityErrorEvent ):void {
            var  loader:LoaderInfo = LoaderInfo( event.target );
            var message:Object = { type:Load.SECURITYERROR , loaderInfo:loader };
            Load.processMessage( loader , message );
        }

        private static function loadMovieHttpStatus( event:HTTPStatusEvent ):void {
            var loader:LoaderInfo = LoaderInfo( event.target );
            var message:Object = { type:Load.HTTPSTATUS , loaderInfo:loader };
			Load.processMessage( loader , message );
        }

        private static function loadMovieIoError( event:IOErrorEvent ):void {
            var loader:LoaderInfo = LoaderInfo( event.target );
            var message:Object = { type:Load.IOERROR , loaderInfo:loader };
			Load.processMessage( loader , message );
        }
        
        
        //HELPER METHODS
        
        private static function init():void
		{
			if( !Load.requests )
			{
				Load.requests = new Dictionary();
			}
		}
		
		//HELPER METHODS
		
		//call methods with messages
		private static function processMessage( loader:Object , message:Object ):void
		{
			var handler:Function = Load.requests[ loader ].handler as Function;
            if( handler != null ){
				handler( message );
			}else{
				Message.send( message )
			}
		}
		
		//prepare request object and params across all types
		private static function prepareRequest( url:String , handler:Object , parameters:Object=null):Object
		{
			//filter input
            if( parameters == null ) parameters = {};
            if( !parameters.name ){ parameters.name = ""};
            if( !parameters.method ){ parameters.method = 'get' };
            parameters.url = url;
            parameters.handler = handler;
            parameters.method = String( parameters.method ).toLowerCase();
            
            //create the request
            var request:URLRequest = new URLRequest( parameters.url );
            
            if( parameters.method == 'get')
            {
	            request.method = URLRequestMethod.GET;
            }
            else if( parameters.method == 'post')
            {
	            request.method = URLRequestMethod.POST;
            }
            else
            {
            	request.method = URLRequestMethod.GET;
            }
            
            //handle data
            if ( parameters.data )
            {
	            var variables:URLVariables = new URLVariables();
	            for( var i:String in parameters.data )
	            {
	            	variables[ i ] = parameters.data[ i ]; 
	            }
	            request.data = variables;
            }
            
            parameters.request = request;
            return parameters;
            
		}
		
	}
}