package com.metaphile.id3.parsers
{
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.*;
	import com.metaphile.id3.utilities.*;
	import flash.utils.ByteArray;
	import com.metaphile.logging.ParseLog;
	
	public class PRIVParser extends FrameParser
	{
		
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
			ParseLog.parsed(this, "size: {0} (+10)", size, bytes.position);
			var data:ByteArray = new ByteArray();
			readFlags( frame, bytes, version );
			if(frame.compression){
				size = uncompressFrame(size, bytes);
				ParseLog.parsed(this, "uncompressed size: {0} (+10)", size, bytes.position);
			}
			var start:uint = bytes.position;
			frame.owner = ID3.readString(bytes);
			ParseLog.parsed(this, "owner: {0}", frame.owner, bytes.position);
			var dataSize:uint = size-(bytes.position-start);
			ParseLog.parsed(this, "( data size = {0} )", dataSize, bytes.position);
			if(dataSize > 0) { bytes.readBytes(data,0,dataSize); }
			ParseLog.parsed(this, "read data", 0, bytes.position);
			data.position = 0;
			frame.data = data;
			return frame;
		}
		
	}
}