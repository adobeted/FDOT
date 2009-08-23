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
//		//load amf
// 		Load.amf( 'http://onflex.org/f/Load/test.amf' );
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
		
		public static const AMF:String = "f.net.Load.AMF";
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
		
		public function unload():void
		{
			this.parameters.loader.unload();
		}
		
		public function load():void
		{
			if( url == null) return;
			switch ( this.resultFormat ){
				
				case Load.AMF:
					Load.amf( this.url , this.eventCallback , this.parameters );
					break;
					
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
		
		public static function amf( url:String , callback:Function , parameters:Object=null ):void
		{
			if( parameters == null ) parameters = {};
			parameters.resultFormat = Load.AMF;
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
			var urlLoader:URLLoader = new URLLoader();
            
            //configure listeners
            urlLoader.addEventListener( Event.COMPLETE , Load.loadDataComplete );
            urlLoader.addEventListener( Event.OPEN , Load.loadDataOpen );
            urlLoader.addEventListener( ProgressEvent.PROGRESS , Load.loadDataProgress );
            urlLoader.addEventListener( SecurityErrorEvent.SECURITY_ERROR , Load.loadDataSecurityError );
            urlLoader.addEventListener( HTTPStatusEvent.HTTP_STATUS , Load.loadDataHttpStatus );
            urlLoader.addEventListener( IOErrorEvent.IO_ERROR , Load.loadDataIoError );
            
            //store request
            Load.requests[ urlLoader ] = prepareRequest( url, callback, parameters );
            
            //store loader
            Load.requests[ urlLoader ].loader = urlLoader;
            
            try {
                urlLoader.load( Load.requests[ urlLoader ].request );
            } catch ( error:Error ) {
                trace("Unable to load requested document.");
            }
            
		}
		
		private static function loadDataClean( urlLoader:URLLoader ):void
		{
			//clean up
			delete Load.requests[ urlLoader ].callback;
			delete Load.requests[ urlLoader ].loader;
			delete Load.requests[ urlLoader ];
			
            urlLoader.removeEventListener( Event.COMPLETE , loadDataComplete );
            urlLoader.removeEventListener( Event.OPEN , loadDataOpen );
            urlLoader.removeEventListener( ProgressEvent.PROGRESS , loadDataProgress );
            urlLoader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , loadDataSecurityError );
            urlLoader.removeEventListener( HTTPStatusEvent.HTTP_STATUS , loadDataHttpStatus );
            urlLoader.removeEventListener( IOErrorEvent.IO_ERROR , loadDataIoError );
		}

        private static function loadDataComplete(event:Event):void {
            var urlLoader:URLLoader = URLLoader( event.target );
            var resultFormat:String = Load.requests[ urlLoader ].resultFormat;
            var message:LoadEvent = new LoadEvent( LoadEvent.SUCCESS );
            message.loader = urlLoader; 
            if( Load.requests[ urlLoader ].status ) message.status = Load.requests[ urlLoader ].status
            if( resultFormat == Load.E4X){
            	//trace( 'resultFormat == erx');
            	message.data = new XML( urlLoader.data );
            }else if( resultFormat == Load.XMLDOC ){
            	//trace( 'resultFormat == xmldoc'); 
            	message.data = new XMLDocument( urlLoader.data );
            }else if( resultFormat == Load.JSON ){
            	//trace( 'resultFormat == json'); 
            	message.data = f.data.format.json.JSON.decode( urlLoader.data );
            }else if( resultFormat == Load.TEXT ){
            	//trace( 'resultFormat == text');
            	message.data = urlLoader.data;
            }else if( resultFormat == Load.QUERYSTRING ){
            	//trace( 'resultFormat == querystring');
            	message.data = new URLVariables( urlLoader.data );
            }else{
            	//default
            	message.data = urlLoader.data;
            }
            Load.processMessage( urlLoader , message );
            
            //chain complete to close events
            Load.loadDataClose( event );
		}
		
		private static function loadDataClose( event:Event ):void {
            var urlLoader:URLLoader = URLLoader( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.CLOSE );
            message.loader = urlLoader;
			Load.processMessage( urlLoader , message );
			Load.loadDataClean( urlLoader );
        }
        
        private static function loadDataOpen( event:Event ):void {
            var urlLoader:URLLoader = URLLoader( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.OPEN );
            message.loader = urlLoader;
			Load.processMessage( urlLoader , message );
        }

        private static function loadDataProgress( event:ProgressEvent ):void {
            var urlLoader:URLLoader = URLLoader( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.PROGRESS );
            message.loader = urlLoader;
			if( event.bytesLoaded ) message.bytesLoaded = event.bytesLoaded;
            if( event.bytesTotal ) message.bytesTotal = event.bytesTotal;
			if( event.bytesTotal && event.bytesLoaded ) message.percent = Number( Number( event.bytesLoaded / event.bytesTotal * 100 ).toPrecision( 4 ) );
            Load.processMessage( urlLoader , message );
		 }

        private static function loadDataSecurityError( event:SecurityErrorEvent ):void {
            var urlLoader:URLLoader = URLLoader( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.FAIL );
            message.loader = urlLoader;
			message.error = event.text;
            if( Load.requests[ urlLoader ].status ) message.status = Load.requests[ urlLoader ].status;
			Load.processMessage( urlLoader , message );
            Load.loadDataClose( event );
        }

        private static function loadDataHttpStatus( event:HTTPStatusEvent ):void {
            var urlLoader:URLLoader = URLLoader( event.target );
            //write status into requestobj
            Load.requests[ urlLoader ].status = event.status;
        }

        private static function loadDataIoError( event:IOErrorEvent ):void {
            var urlLoader:URLLoader = URLLoader( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.FAIL );
            message.error = event.text;
			message.loader = urlLoader;
            if( Load.requests[ urlLoader ].status ) message.status = Load.requests[ urlLoader ].status;
            Load.processMessage( urlLoader , message );
            Load.loadDataClose( event );
        }
		
		
		
		// LOADSTREAM
		//---------------------------
		
		//handles loading ASCII data
		private static function loadStream( url:String , callback:Function , parameters:Object=null ):void
		{
			Load.init();
			var urlStream:URLStream = new URLStream();
            
            //configure listeners
            urlStream.addEventListener( Event.COMPLETE , Load.loadStreamComplete );
            urlStream.addEventListener( Event.OPEN , Load.loadStreamOpen );
            urlStream.addEventListener( ProgressEvent.PROGRESS , Load.loadStreamProgress );
            urlStream.addEventListener( SecurityErrorEvent.SECURITY_ERROR , Load.loadStreamSecurityError );
            urlStream.addEventListener( HTTPStatusEvent.HTTP_STATUS , Load.loadStreamHttpStatus );
            urlStream.addEventListener( IOErrorEvent.IO_ERROR , Load.loadStreamIoError );
            
            //store request
            Load.requests[ urlStream ] = prepareRequest( url, callback, parameters );
            
            //store loader
            Load.requests[ urlStream ].loader = urlStream;
            
            try {
                urlStream.load( Load.requests[ urlStream ].request );
            } catch ( error:Error ) {
                trace("Unable to load requested document.");
            }
		}
		
		private static function loadStreamClean( urlStream:URLStream ):void
		{
			//clean up
			delete Load.requests[ urlStream ].callback;
			delete Load.requests[ urlStream ].loader;
			delete Load.requests[ urlStream ];
			
            urlStream.removeEventListener( Event.COMPLETE , loadStreamComplete );
            urlStream.removeEventListener( Event.OPEN , loadStreamOpen );
            urlStream.removeEventListener( ProgressEvent.PROGRESS , loadStreamProgress );
            urlStream.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , loadStreamSecurityError );
            urlStream.removeEventListener( HTTPStatusEvent.HTTP_STATUS , loadStreamHttpStatus );
            urlStream.removeEventListener( IOErrorEvent.IO_ERROR , loadStreamIoError );
		}

        private static function loadStreamComplete(event:Event):void {
            var urlStream:URLStream = URLStream( event.target );
            var bytesOut:ByteArray = new ByteArray();
            urlStream.readBytes( bytesOut );
 			var message:LoadEvent = new LoadEvent( LoadEvent.SUCCESS );
            message.loader = urlStream;
            if( Load.requests[ urlStream ].status ) message.status = Load.requests[ urlStream ].status
			if( Load.requests[ urlStream ].resultFormat == Load.AMF ){
				message.data = bytesOut.readObject();
			}else{
				message.data = bytesOut;
        	}
			Load.processMessage( urlStream , message );
			
            //chain complete to close events
            Load.loadStreamClose( event );
		}

        private static function loadStreamClose( event:Event ):void {
            var urlStream:URLStream = URLStream( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.CLOSE );
            message.loader = urlStream;
			Load.processMessage( urlStream , message );
			Load.loadStreamClean( urlStream );
        }
        
        private static function loadStreamOpen( event:Event ):void {
            var urlStream:URLStream = URLStream( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.OPEN );
            message.loader = urlStream;
			Load.processMessage( urlStream , message );
        }

        private static function loadStreamProgress( event:ProgressEvent ):void {
            var urlStream:URLStream = URLStream( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.PROGRESS );
            message.loader = urlStream;
            message.bytesAvailable = urlStream.bytesAvailable;
            if( event.bytesLoaded ) message.bytesLoaded = event.bytesLoaded;
            if( event.bytesTotal ) message.bytesTotal = event.bytesTotal;
			if( event.bytesTotal && event.bytesLoaded ) message.percent = Number( Number( event.bytesLoaded / event.bytesTotal * 100 ).toPrecision( 4 ) );
            Load.processMessage( urlStream , message );
		 }

        private static function loadStreamSecurityError( event:SecurityErrorEvent ):void {
            var urlStream:URLStream = URLStream( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.FAIL );
            message.error = event.text;
            if( Load.requests[ urlStream ].status ) message.status = Load.requests[ urlStream ].status
			message.loader = urlStream;
            message.error = event.text;
			Load.processMessage( urlStream , message );
            Load.loadStreamClose( event );
        }

        private static function loadStreamHttpStatus( event:HTTPStatusEvent ):void {
           var urlStream:URLStream = URLStream( event.target );
            //write status into requestobj
            Load.requests[ urlStream ].status = event.status;
        }

        private static function loadStreamIoError( event:IOErrorEvent ):void {
            var urlStream:URLStream = URLStream( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.FAIL );
            message.error = event.text;
            if( Load.requests[ urlStream ].status ) message.status = Load.requests[ urlStream ].status
			message.loader = urlStream;
           	Load.processMessage( urlStream , message );
            Load.loadStreamClose( event );
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
            Load.requests[ loader.contentLoaderInfo ] = prepareRequest( url, callback, parameters );
            
            //store loader
            Load.requests[ loader.contentLoaderInfo ].loader = loader;
            
            try {
                loader.load( Load.requests[ loader.contentLoaderInfo ].request );
            } catch ( error:Error ) {
                trace("Unable to load requested document.");
            }
		}
		
		private static function loadMovieClean( loaderInfo:LoaderInfo ):void
		{
			//clean up
			delete Load.requests[ loaderInfo ].callback;
			delete Load.requests[ loaderInfo ].loader
			delete Load.requests[ loaderInfo ];
			
			loaderInfo.removeEventListener( Event.COMPLETE , Load.loadMovieComplete );
            loaderInfo.removeEventListener( Event.OPEN , Load.loadMovieOpen );
            loaderInfo.removeEventListener( Event.INIT , Load.loadMovieInit );
            loaderInfo.removeEventListener( ProgressEvent.PROGRESS , Load.loadMovieProgress );
            loaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , Load.loadMovieSecurityError );
            loaderInfo.removeEventListener( HTTPStatusEvent.HTTP_STATUS , Load.loadMovieHttpStatus );
            loaderInfo.removeEventListener( IOErrorEvent.IO_ERROR , Load.loadMovieIoError );
		}
		
		//MOVIE EVENTS
        private static function loadMovieComplete( event:Event ):void {
            var loaderInfo:LoaderInfo = LoaderInfo( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.SUCCESS );
			message.loader = loaderInfo.loader;
			message.data = loaderInfo.loader as Loader;
            if( Load.requests[ loaderInfo ].status ) message.status = Load.requests[ loaderInfo ].status
			Load.processMessage( loaderInfo , message );
			loadMovieClose( event );
		}
		
		private static function loadMovieClose( event:Event ):void {
            var loaderInfo:LoaderInfo = LoaderInfo( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.CLOSE );
			message.loader = loaderInfo;
            Load.processMessage( loaderInfo , message );
			Load.loadMovieClean( loaderInfo );
        }
        
		private static function loadMovieOpen( event:Event ):void {
            var loaderInfo:LoaderInfo = LoaderInfo( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.OPEN );
			message.loader = loaderInfo;
            Load.processMessage( loaderInfo , message );
        }
        
        private static function loadMovieInit(event:Event):void {
            var loaderInfo:LoaderInfo = LoaderInfo( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.INIT );
			message.loader = loaderInfo;
			Load.processMessage( loaderInfo , message );
        }

        private static function loadMovieProgress( event:ProgressEvent ):void {
            var loaderInfo:LoaderInfo = LoaderInfo( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.PROGRESS );
			message.loader = loaderInfo;
			if( event.bytesLoaded ) message.bytesLoaded = event.bytesLoaded;
            if( event.bytesTotal ) message.bytesTotal = event.bytesTotal;
			if( event.bytesTotal && event.bytesLoaded ) message.percent = Number( Number( event.bytesLoaded / event.bytesTotal * 100 ).toPrecision( 4 ) );
            Load.processMessage( loaderInfo , message );
		}

        private static function loadMovieSecurityError( event:SecurityErrorEvent ):void {
            var  loaderInfo:LoaderInfo = LoaderInfo( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.FAIL );
            message.error = event.text;
			message.loader = loaderInfo;
			if( Load.requests[ loaderInfo ].status ) message.status = Load.requests[ loaderInfo ].status
			Load.processMessage( loaderInfo , message );
			loadMovieClose( event );
        }

        private static function loadMovieHttpStatus( event:HTTPStatusEvent ):void {
            var loaderInfo:LoaderInfo = LoaderInfo( event.target );
            Load.requests[ loaderInfo ].status = event.status;
        }

        private static function loadMovieIoError( event:IOErrorEvent ):void {
            var loaderInfo:LoaderInfo = LoaderInfo( event.target );
            var message:LoadEvent = new LoadEvent( LoadEvent.FAIL );
            message.error = event.text;
			message.loader = loaderInfo;
			if( Load.requests[ loaderInfo ].status ) message.status = Load.requests[ loaderInfo ].status
			Load.processMessage( loaderInfo , message );
			loadMovieClose( event );
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