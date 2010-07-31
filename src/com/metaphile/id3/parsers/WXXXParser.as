package com.metaphile.id3.parsers
{
	import com.metaphile.id3.*;
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.utilities.*;
	
	import flash.utils.ByteArray;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class WXXXParser extends FrameParser
	{
		
		CONFIG::debugging { private var logger:ILogger = Log.getLogger(flash.utils.getQualifiedClassName(this).replace("::", ".")); }
		
		public function WXXXParser( successor:FrameParser = null ) {
			super(successor);
		}
		
		override public function readFrame(id:String, bytes:ByteArray, version:Number):Frame {
			if(id=="WXXX" || id=="WXX") {
				return readWXXXFrame(bytes, version);
			} else { return successor.readFrame(id, bytes, version); }
		}
		
		private function readWXXXFrame( bytes:ByteArray, version:Number ):Frame {
			var frame:WXXXFrame = new WXXXFrame();
			var size:uint = ID3.readInt(bytes, version);
			CONFIG::debugging { logger.info("size: {0} (+10)", size, bytes.position); }
			readFlags( frame, bytes, version );
			if(frame.compression){
				size = uncompressFrame(size, bytes);
				CONFIG::debugging { logger.info("uncompressed size: {0} (+10)", size, bytes.position); }
			}
			var start:uint = bytes.position;
			frame.encoding = bytes.readUnsignedByte();
			CONFIG::debugging { logger.info("encoding: {0}", frame.encoding, bytes.position); }
			frame.description = ID3.readString(bytes, frame.encoding);
			CONFIG::debugging { logger.info("description: {0}", frame.description, bytes.position); }
			frame.url = ID3.readString(bytes, frame.encoding, size - (bytes.position - start));
			CONFIG::debugging { logger.info("url: {0}", frame.url, bytes.position); }
			return frame;
		}
		
	}
}