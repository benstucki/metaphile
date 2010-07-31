package com.metaphile.id3.parsers
{
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.*;
	import com.metaphile.id3.utilities.*;
	import flash.utils.ByteArray;
	import com.metaphile.logging.ParseLog;
	
	public class GEOBParser extends FrameParser
	{
		
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
			ParseLog.parsed(this, "size: {0} (+10)", size, bytes.position);
			var data:ByteArray = new ByteArray();
			readFlags( frame, bytes, version );
			if(frame.compression){
				size = uncompressFrame(size, bytes);
				ParseLog.parsed(this, "uncompressed size: {0} (+10)", size, bytes.position);
			}
			var start:uint = bytes.position;
			frame.encoding = bytes.readUnsignedByte();
			ParseLog.parsed(this, "encoding: {0}", frame.encoding, bytes.position);
			frame.mime = ID3.readString(bytes);
			ParseLog.parsed(this, "mime: {0}", frame.mime, bytes.position);
			frame.objectType = bytes.readUnsignedByte();
			ParseLog.parsed(this, "type: {0}", frame.objectType, bytes.position);
			frame.filename = ID3.readString(bytes, frame.encoding);
			ParseLog.parsed(this, "type: {0}", frame.filename, bytes.position);
			frame.description = ID3.readString(bytes, frame.encoding);
			ParseLog.parsed(this, "description: {0}", frame.description, bytes.position);
			var dataSize:uint = size-(bytes.position-start);
			ParseLog.parsed(this, "( image size = {0} )", dataSize, bytes.position);
			if(dataSize > 0) { bytes.readBytes(data,0,dataSize); }
			ParseLog.parsed(this, "read object", null, bytes.position);
			data.position = 0;
			frame.data = data;
			return frame;
		}
	}
}