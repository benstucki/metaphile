package com.metaphile.id3.parsers
{
	import com.metaphile.id3.*;
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.utilities.*;
	
	import flash.utils.ByteArray;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class POPMParser extends FrameParser
	{
		
		CONFIG::debugging { private var logger:ILogger = Log.getLogger(flash.utils.getQualifiedClassName(this).replace("::", ".")); }
		
		public function POPMParser( successor:FrameParser = null ) {
			super( successor );
		}
		
		override public function readFrame(id:String, bytes:ByteArray, version:Number):Frame {
			if(id=="POPM" || id=="POP") {
				return readPOPMFrame(bytes, version);
			} else { return successor.readFrame(id, bytes, version); }
		}
		
		private function readPOPMFrame(bytes:ByteArray, version:Number):Frame {
			var frame:POPMFrame = new POPMFrame();
			var size:uint = ID3.readInt(bytes, version);
			CONFIG::debugging { logger.info("size: {0} (+10)", size, bytes.position); }
			readFlags( frame, bytes, version );
			if(frame.compression){
				size = uncompressFrame(size, bytes);
				CONFIG::debugging { logger.info("uncompressed size: {0} (+10)", size, bytes.position); }
			}
			frame.user = ID3.readString(bytes);
			CONFIG::debugging { logger.info("user: {0}", frame.user, bytes.position); }
			frame.rating = bytes.readUnsignedByte();
			CONFIG::debugging { logger.info("rating: {0}", frame.rating, bytes.position); }
			frame.counter = bytes.readUnsignedInt();
			CONFIG::debugging { logger.info("counter: {0}", frame.counter, bytes.position); }
			return frame;
		}
	}
}