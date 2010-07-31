package com.metaphile.id3.parsers
{
	import com.metaphile.id3.*;
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.utilities.*;
	
	import flash.utils.ByteArray;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class PRIVParser extends FrameParser
	{
		
		CONFIG::debugging { private var logger:ILogger = Log.getLogger(flash.utils.getQualifiedClassName(this).replace("::", ".")); }
		
		public function PRIVParser( successor:FrameParser = null ):void {
			super(successor);
		}
		
		override public function readFrame(id:String, bytes:ByteArray, version:Number):Frame {
			if(id=="PRIV") {
				return readPRIVFrame(bytes, version);
			} else { return successor.readFrame(id, bytes, version); }
		}
		
		private function readPRIVFrame(bytes:ByteArray, version:Number = 2.3):Frame {
			var frame:PRIVFrame = new PRIVFrame();
			var size:int = ID3.readInt(bytes, version);
			CONFIG::debugging { logger.info("size: {0} (+10)", size, bytes.position); }
			var data:ByteArray = new ByteArray();
			readFlags( frame, bytes, version );
			if(frame.compression){
				size = uncompressFrame(size, bytes);
				CONFIG::debugging { logger.info("uncompressed size: {0} (+10)", size, bytes.position); }
			}
			var start:uint = bytes.position;
			frame.owner = ID3.readString(bytes);
			CONFIG::debugging { logger.info("owner: {0}", frame.owner, bytes.position); }
			var dataSize:uint = size-(bytes.position-start);
			CONFIG::debugging { logger.info("( data size = {0} )", dataSize, bytes.position); }
			if(dataSize > 0) { bytes.readBytes(data,0,dataSize); }
			CONFIG::debugging { logger.info("read data", 0, bytes.position); }
			data.position = 0;
			frame.data = data;
			return frame;
		}
		
	}
}