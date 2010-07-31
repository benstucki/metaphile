package com.metaphile.id3.parsers
{
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.utilities.*;
	import com.metaphile.id3.*;
	import flash.utils.ByteArray;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class TXXXParser extends FrameParser
	{
		
		CONFIG::debugging { private var logger:ILogger = Log.getLogger(flash.utils.getQualifiedClassName(this).replace("::", ".")); }
		
		public function TXXXParser( successor:FrameParser = null ) {
			super(successor);
		}
		
		override public function readFrame(id:String, bytes:ByteArray, version:Number):Frame {
			if(id=="TXXX" || id=="TXX") {
				return readTXXXFrame(bytes, version);
			} else { return successor.readFrame(id, bytes, version); }
		}
		
		private function readTXXXFrame( bytes:ByteArray, version:Number ):Frame {
			var frame:TXXXFrame = new TXXXFrame();
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
			frame.text = ID3.readString(bytes, frame.encoding, size - (bytes.position - start));
			CONFIG::debugging { logger.info("text: {0}", frame.text, bytes.position); }
			return frame;
		}
		
	}
}