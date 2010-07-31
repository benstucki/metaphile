package com.metaphile.id3.parsers
{
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.utilities.*;
	import com.metaphile.id3.*;
	import flash.utils.ByteArray;
	import com.metaphile.logging.ParseLog;
	
	public class WXXXParser extends FrameParser
	{
		
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
			ParseLog.parsed(this, "size: {0} (+10)", size, bytes.position);
			readFlags( frame, bytes, version );
			if(frame.compression){
				size = uncompressFrame(size, bytes);
				ParseLog.parsed(this, "uncompressed size: {0} (+10)", size, bytes.position);
			}
			var start:uint = bytes.position;
			frame.encoding = bytes.readUnsignedByte();
			ParseLog.parsed(this, "encoding: {0}", frame.encoding, bytes.position);
			frame.description = ID3.readString(bytes, frame.encoding);
			ParseLog.parsed(this, "description: {0}", frame.description, bytes.position);
			frame.url = ID3.readString(bytes, frame.encoding, size - (bytes.position - start));
			ParseLog.parsed(this, "url: {0}", frame.url, bytes.position);
			return frame;
		}
		
	}
}