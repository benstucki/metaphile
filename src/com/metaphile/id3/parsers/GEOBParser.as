package com.metaphile.id3.parsers
{
	import com.metaphile.id3.*;
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.utilities.*;
	
	import flash.utils.ByteArray;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class GEOBParser extends FrameParser
	{
		
		CONFIG::debugging { private var logger:ILogger = Log.getLogger(flash.utils.getQualifiedClassName(this).replace("::", ".")); }
		
		public function GEOBParser( successor:FrameParser ):void {
			super(successor);
		}
		
		override public function readFrame(id:String, bytes:ByteArray, version:Number):Frame {
			if(id=="GEOB" || id=="GEO") {
				return readGEOBFrame(bytes, version);
			} else { return successor.readFrame(id, bytes, version); }
		}
		
		private function readGEOBFrame(bytes:ByteArray, version:Number):Frame {
			var frame:GEOBFrame = new GEOBFrame();
			var size:int = ID3.readInt(bytes, version);
			CONFIG::debugging { logger.info("size: {0} (+10)", size, bytes.position); }
			var data:ByteArray = new ByteArray();
			readFlags( frame, bytes, version );
			if(frame.compression){
				size = uncompressFrame(size, bytes);
				CONFIG::debugging { logger.info("uncompressed size: {0} (+10)", size, bytes.position); }
			}
			var start:uint = bytes.position;
			frame.encoding = bytes.readUnsignedByte();
			CONFIG::debugging { logger.info("encoding: {0}", frame.encoding, bytes.position); }
			frame.mime = ID3.readString(bytes);
			CONFIG::debugging { logger.info("mime: {0}", frame.mime, bytes.position); }
			frame.objectType = bytes.readUnsignedByte();
			CONFIG::debugging { logger.info("type: {0}", frame.objectType, bytes.position); }
			frame.filename = ID3.readString(bytes, frame.encoding);
			CONFIG::debugging { logger.info("type: {0}", frame.filename, bytes.position); }
			frame.description = ID3.readString(bytes, frame.encoding);
			CONFIG::debugging { logger.info("description: {0}", frame.description, bytes.position); }
			var dataSize:uint = size-(bytes.position-start);
			CONFIG::debugging { logger.info("( image size = {0} )", dataSize, bytes.position); }
			if(dataSize > 0) { bytes.readBytes(data,0,dataSize); }
			CONFIG::debugging { logger.info("read object", null, bytes.position); }
			data.position = 0;
			frame.data = data;
			return frame;
		}
	}
}