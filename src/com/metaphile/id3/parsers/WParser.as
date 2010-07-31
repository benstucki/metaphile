package com.metaphile.id3.parsers
{
	
	import com.metaphile.id3.*;
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.utilities.*;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class WParser extends FrameParser
	{
		
		CONFIG::debugging { private var logger:ILogger = Log.getLogger(flash.utils.getQualifiedClassName(this).replace("::", ".")); }
		
		// holds defined id values for version 1, 2.2, 2.3, and 2.4 respectively.
		// (null if frame does not exist in version)
		private var relationships:Dictionary = new Dictionary();
		
		public function WParser( successor:FrameParser = null ) {
			super( successor );
			setRelationships();
		}
		
		override public function readFrame(id:String, bytes:ByteArray, version:Number):Frame {
			if(id.charAt(0)=="W") {
				var type:uint = getFrameType(id, version);
				if(type!=FrameTypes.UNKNOWN){
					return readWFrame(type, bytes, version);
				} else { return successor.readFrame(id, bytes, version); }
			} else { return successor.readFrame(id, bytes, version); }
		}
		
		private function readWFrame(type:uint, bytes:ByteArray, version:Number):Frame {
			var size:int = ID3.readInt(bytes, version);
			CONFIG::debugging { logger.info("size: {0} (+10)", size, bytes.position); }
			var frame:WFrame = new WFrame( type );
			readFlags(frame, bytes, version);
			if(frame.compression){
				size = uncompressFrame(size, bytes);
				CONFIG::debugging { logger.info("uncompressed size {0} (+10)", size); }
			}
			frame.url = ID3.readString(bytes, 0, size);
			CONFIG::debugging { logger.info("url: {0}", frame.url, bytes.position); }
			return frame;
		}
		
		// frame specific helper functions
		
		private function setRelationships():void {
			relationships[FrameTypes.COMMERCIAL_URI] = new Array("WCM", "WCOM", "WCOM");
			relationships[FrameTypes.ARTIST_URI] = new Array(0, "WOAR", "WOAR");
		}
		
		private function getFrameType(id:String, version:Number):uint {
			var v:uint = 1; //handler.versionIndex;
			switch(version){
				case 2.2:
					result = 0;
				case 2.3:
					result = 1;
				case 2.4:
					result = 2;
			}
			var result:uint = FrameTypes.UNKNOWN;
			for (var type:String in relationships){
				if(id==relationships[type][v]){	
					result = uint(type);
				}
			}
			return result;
		}
	}
}