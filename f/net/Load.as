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
//		//load e4x
// 		Load.e4x( 'http://onflex.org/f/Load/test.xml' );
//	
//		//load xmldoc
// 		Load.xmldoc( 'http://onflex.org/f/Load/test.xml' );
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
//
// Contributors: Ted Patrick
//

package f.net
{
	import f.data.format.json.*;
	import f.events.LoadEvent;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
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
	import flash.xml.XMLDocument;
	
	public class Load extends EventDispatcher
	{
		
		public static const BINARY:String = "f.net.Load.BINARY";
		public static const E4X:String = "f.net.Load.E4X";		
		public static const JSON:String = "f.net.Load.JSON";
		public static const IMAGE:String = "f.net.Load.IMAGE";
		public static const STREAM:String = "f.net.Load.STREAM";
		public static const SWF:String = "f.net.Load.SWF";
		public static const QUERYSTRING:String = "f.net.Load.QUERYSTRING";
		public static const TEXT:String = "f.net.Load.TEXT";
		public static const XMLDOC:String = "f.net.Load.XMLDOC";
		private static var requests:Dictionary;
		
		public var url:String = null;
		public var parameters:Object = null;
		public var resultFormat:String = Load.TEXT;
		
		public function load():void
		{
			if( url == null) return;
			switch ( this.resultFormat ){
				
				case Load.BINARY:
					Load.binary( this.url , this.eventCallback , this.parameters );
					break;
					
				case Load.E4X:
					Load.e4x( this.url , this.eventCallback , this.parameters );
					break;
					
				case Load.IMAGE:
					Load.image( this.url , this.eventCallback , this.parameters );
					break;
					
				case Load.JSON:
					Load.json( this.url , this.eventCallback , this.parameters );
					break;
					
				case Load.QUERYSTRING:
					Load.querystring( this.url , this.eventCallback , this.parameters );
					break;
					
				case Load.STREAM:
					Load.stream( this.url , this.eventCallback , this.parameters );
					break;
					
				case Load.SWF:
					Load.swf( this.url , this.eventCallback , this.parameters );
					break;
					
				case Load.TEXT:
					Load.text( this.url , this.eventCallback , this.parameters );
					break;
					
				case Load.XMLDOC:
					Load.xmldoc( this.url , this.eventCallback , this.parameters );
					break;
					
				case Load.STREAM:
					Load.stream( this.url , this.eventCallback , this.parameters );
					break;
					
				default:
					trace( getTimer() + ' default case fired in error' );
					break;
			}
			
		}
		
		public function Load( url:String=null , parameters:Object=null  ):void
		{
			super();
			if( url != null) this.url = url;
			if( parameters != null) this.parameters = parameters;
		}
		
		private function eventCallback( event:LoadEvent ):void
		{
			this.dispatchEvent( event );
		}
		
		//sample event handler
		public static function sampleSwitchEventHandler( event:LoadEvent ):void
		{
			switch ( event.type ){
				case LoadEvent.CLOSE:
					trace( getTimer() + ' ' + LoadEvent.CLOSE );
					break;
				case LoadEvent.OPEN:
					trace( getTimer() + ' ' + LoadEvent.OPEN );
					break;
				case LoadEvent.SUCCESS:
					trace( getTimer() + ' ' + LoadEvent.SUCCESS );
					break;
				case LoadEvent.INIT:
					trace( getTimer() + ' ' + LoadEvent.INIT );
					break;
				case LoadEvent.FAIL:
					trace( getTimer() + ' ' + LoadEvent.FAIL );
					break;
				case LoadEvent.PROGRESS:
					trace( getTimer() + ' ' + LoadEvent.PROGRESS + ' ' + event.bytesLoaded );
					break;
				default:
					trace( getTimer() + ' default case fired in error' );
					break;
			}
		}
		
		//sample event handler
		public static function sampleEventHandler( event:LoadEvent ):void
		{
			if( event.type == LoadEvent.CLOSE ){
				trace( getTimer() + ' ' + LoadEvent.CLOSE );
			}else if( event.type == LoadEvent.OPEN ){
				trace( getTimer() + ' ' + LoadEvent.OPEN );
			}else if( event.type == LoadEvent.SUCCESS ){
				trace( getTimer() + ' ' + LoadEvent.SUCCESS );
			}else if( event.type == LoadEvent.INIT ){
				trace( getTimer() + ' ' + LoadEvent.INIT );
			}else if( event.type == LoadEvent.FAIL ){
				trace( getTimer() + ' ' + LoadEvent.FAIL );
			}else if( event.type == LoadEvent.PROGRESS ){
				trace( getTimer() + ' ' + LoadEvent.PROGRESS + ' ' + event.bytesLoaded );
			}else{
				trace( getTimer() + ' default case fired in error' );			
			}
		}
		
		public static function swf( url:String , callback:Function , parameters:Object=null ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = Load.SWF;
			Load.loadMovie( url , callback , parameters );		
		}
		
		public static function image( url:String , callback:Function , parameters:Object=null  ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = Load.IMAGE;
			Load.loadMovie( url , callback , parameters );		
		}
		
		public static function binary( url:String , callback:Function , parameters:Object=null ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = Load.BINARY;
			Load.loadStream( url , callback , parameters );		
		}
		
		public static function stream( url:String , callback:Function , parameters:Object=null ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = Load.STREAM;
			Load.loadStream( url , callback , parameters );		
		}
		
		public static function querystring( url:String , callback:Function , parameters:Object=null ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = Load.QUERYSTRING;
			Load.loadData( url , callback , parameters );		
		}
		
		public static function text( url:String , callback:Function , parameters:Object=null  ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = Load.TEXT;
			return Load.loadData( url , callback , parameters );		
		}
		
		public static function json( url:String , callback:Function , parameters:Object=null ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = Load.JSON;
			Load.loadData( url , callback , parameters );		
		}
		
		public static function e4x( url:String , callback:Function , parameters:Object=null ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = Load.E4X;
			Load.loadData( url , callback , parameters );		
		}
		
		public static function xmldoc( url:String , callback:Function , parameters:Object=null ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = Load.XMLDOC;
			Load.loadData( url , callback , parameters );		
		}
		
		
		
		
        // LOADDATA
		//---------------------------
		
		//handles loading ASCII data
		private static function loadData( url:String , callback:Function , parameters:Object=null ):void
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
            Load.requests[ loader ] = prepareRequest( url, callback, parameters );
            
            try {
                loader.load( Load.requests[ loader ].request );
            } catch ( error:Error ) {
                trace("Unable to load requested document.");
            }
            
		}

        private static function loadDataComplete(event:Event):void {
            var loader:URLLoader = URLLoader( event.target );
            var resultFormat:String = Load.requests[ loader ].resultFormat;
            var message:LoadEvent = new LoadEvent( LoadEvent.SUCCESS );
            message.loader = loader; 
            if( Load.requests[ loader ].status ) message.status = Load.requests[ loader ].status
            if( resultFormat == Load.E4X){
            	//trace( 'resultFormat == erx');
            	message.data = new XML( loader.data );
            }else if( resultFormat == Load.XMLDOC ){
            	//trace( 'resultFormat == xmldoc'); 
            	message.data = new XMLDocument( loader.data );
            }else if( resultFormat == Load.JSON ){
            	//trace( 'resultFormat == json'); 
            	message.data = f.data.format.json.JSON.decode( loader.data );
            }else if( resultFormat == Load.TEXT ){
            	//trace( 'resultFormat == text');
            	message.data = loader.data;
            }else if( resultFormat == Load.QUERYSTRING ){
            	//trace( 'resultFormat == querystring');
            	message.data = new URLVariables( loader.data );
            }else{
            	//default
            	message.data = loader.data;
            }
            Load.processMessage( loader , message );
			
			//clean up
			delete Load.requests[ loader ].callback;
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
            var message:LoadEvent = new LoadEvent( LoadEvent.OPEN );
            message.loader = loader;
			Load.processMessage( loader , message );
        }

        private static function loadDataProgress( event:ProgressEvent ):void {
            var loader:URLLoader = URLLoader( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.PROGRESS );
            message.loader = loader;
			if( event.bytesLoaded ) message.bytesLoaded = event.bytesLoaded;
            if( event.bytesTotal ) message.bytesTotal = event.bytesTotal;
			if( event.bytesTotal && event.bytesLoaded ) message.percent = Number( Number( event.bytesLoaded / event.bytesTotal * 100 ).toPrecision( 4 ) );
            Load.processMessage( loader , message );
		 }

        private static function loadDataSecurityError(event:SecurityErrorEvent):void {
            var loader:URLLoader = URLLoader( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.FAIL );
            message.loader = loader;
			message.error = event.text;
            if( Load.requests[ loader ].status ) message.status = Load.requests[ loader ].status;
			Load.processMessage( loader , message );
        }

        private static function loadDataHttpStatus(event:HTTPStatusEvent):void {
            var loader:URLLoader = URLLoader( event.target );
            //write status into requestobj
            Load.requests[ loader ].status = event.status;
        }

        private static function loadDataIoError(event:IOErrorEvent):void {
            var loader:URLLoader = URLLoader( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.FAIL );
            message.error = event.text;
			message.loader = loader;
            if( Load.requests[ loader ].status ) message.status = Load.requests[ loader ].status;
            Load.processMessage( loader , message );
        }
		
		
		
		// LOADSTREAM
		//---------------------------
		
		//handles loading ASCII data
		private static function loadStream( url:String , callback:Function , parameters:Object=null ):void
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
            Load.requests[ loader ] = prepareRequest( url, callback, parameters );
            
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
 			var message:LoadEvent = new LoadEvent( LoadEvent.SUCCESS );
            message.loader = loader;
            if( Load.requests[ loader ].status ) message.status = Load.requests[ loader ].status
			message.data = bytesOut;
			Load.processMessage( loader , message );
			
			//clean up
			delete Load.requests[ loader ].callback;
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
            var message:LoadEvent = new LoadEvent( LoadEvent.OPEN );
            message.loader = loader;
			Load.processMessage( loader , message );
        }

        private static function loadStreamProgress( event:ProgressEvent ):void {
            var loader:URLStream = URLStream( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.PROGRESS );
            message.loader = loader;
            message.bytesAvailable = loader.bytesAvailable;
            if( event.bytesLoaded ) message.bytesLoaded = event.bytesLoaded;
            if( event.bytesTotal ) message.bytesTotal = event.bytesTotal;
			if( event.bytesTotal && event.bytesLoaded ) message.percent = Number( Number( event.bytesLoaded / event.bytesTotal * 100 ).toPrecision( 4 ) );
            Load.processMessage( loader , message );
		 }

        private static function loadStreamSecurityError( event:SecurityErrorEvent ):void {
            var loader:URLStream = URLStream( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.FAIL );
            message.error = event.text;
            if( Load.requests[ loader ].status ) message.status = Load.requests[ loader ].status
			message.loader = loader;
            message.error = event.text;
			Load.processMessage( loader , message );
        }

        private static function loadStreamHttpStatus( event:HTTPStatusEvent ):void {
           var loader:URLStream = URLStream( event.target );
            //write status into requestobj
            Load.requests[ loader ].status = event.status;
        }

        private static function loadStreamIoError( event:IOErrorEvent ):void {
            var loader:URLStream = URLStream( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.FAIL );
            message.error = event.text;
            if( Load.requests[ loader ].status ) message.status = Load.requests[ loader ].status
			message.loader = loader;
           	Load.processMessage( loader , message );
        }
		
		
		
		
		// LOADMOVIE
		//---------------------------
		
		//handles loading DisplayObjects
		private static function loadMovie( url:String , callback:Function , parameters:Object=null ):void
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
            parameters = Load.requests[ loader.contentLoaderInfo ] = prepareRequest( url, callback, parameters );
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
            var loaderInfo:LoaderInfo = LoaderInfo( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.SUCCESS );
			message.loader = loaderInfo.loader;
			message.data = loaderInfo.loader as Loader;
            if( Load.requests[ loaderInfo ].status ) message.status = Load.requests[ loaderInfo ].status
			Load.processMessage( loaderInfo , message );
			
			//clean up
			delete Load.requests[ loaderInfo ].callback;
			delete Load.requests[ loaderInfo ];
			
            loaderInfo.removeEventListener( Event.COMPLETE , Load.loadMovieComplete );
            loaderInfo.removeEventListener( Event.OPEN , Load.loadMovieOpen );
            loaderInfo.removeEventListener( Event.INIT , Load.loadMovieInit );
            loaderInfo.removeEventListener( ProgressEvent.PROGRESS , Load.loadMovieProgress );
            loaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , Load.loadMovieSecurityError );
            loaderInfo.removeEventListener( HTTPStatusEvent.HTTP_STATUS , Load.loadMovieHttpStatus );
            loaderInfo.removeEventListener( IOErrorEvent.IO_ERROR , Load.loadMovieIoError );
		}
		
		private static function loadMovieOpen( event:Event ):void {
            var loader:LoaderInfo = LoaderInfo( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.OPEN );
			message.loader = loader;
            Load.processMessage( loader , message );
        }
        
        private static function loadMovieInit(event:Event):void {
            var loader:LoaderInfo = LoaderInfo( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.INIT );
			message.loader = loader;
			Load.processMessage( loader , message );
        }

        private static function loadMovieProgress( event:ProgressEvent ):void {
            var loader:LoaderInfo = LoaderInfo( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.PROGRESS );
			message.loader = loader;
			if( event.bytesLoaded ) message.bytesLoaded = event.bytesLoaded;
            if( event.bytesTotal ) message.bytesTotal = event.bytesTotal;
			if( event.bytesTotal && event.bytesLoaded ) message.percent = Number( Number( event.bytesLoaded / event.bytesTotal * 100 ).toPrecision( 4 ) );
            Load.processMessage( loader , message );
		}

        private static function loadMovieSecurityError( event:SecurityErrorEvent ):void {
            var  loader:LoaderInfo = LoaderInfo( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.FAIL );
            message.error = event.text;
			message.loader = loader;
			if( Load.requests[ loader ].status ) message.status = Load.requests[ loader ].status
			Load.processMessage( loader , message );
        }

        private static function loadMovieHttpStatus( event:HTTPStatusEvent ):void {
            var loader:LoaderInfo = LoaderInfo( event.target );
            Load.requests[ loader ].status = event.status;
        }

        private static function loadMovieIoError( event:IOErrorEvent ):void {
            var loader:LoaderInfo = LoaderInfo( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.FAIL );
            message.error = event.text;
			message.loader = loader;
			if( Load.requests[ loader ].status ) message.status = Load.requests[ loader ].status
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
			var callback:Function = Load.requests[ loader ].callback as Function;
            if( callback != null ){
				callback( message );
			}
		}
		
		//prepare request object and params across all types
		private static function prepareRequest( url:String , callback:Object , parameters:Object=null):Object
		{
			//filter input
            if( parameters == null ) parameters = {};
            if( !parameters.name ){ parameters.name = ""};
            if( !parameters.method ){ parameters.method = 'get' };
            parameters.url = url;
            parameters.callback = callback;
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