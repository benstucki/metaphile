package com.metaphile.id3.parsers
{
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.utilities.*;
	import com.metaphile.id3.*;
	import flash.utils.ByteArray;
	import com.metaphile.logging.ParseLog;
	
	public class PCNTParser extends FrameParser
	{
		
		public function PCNTParser( successor:FrameParser = null ) {
			super( successor );
		}
		
		override public function readFrame(id:String, bytes:ByteArray, version:Number):Frame {
			if(id=="PCNT" || id=="CNT") {
				return readPCNTFrame(bytes, version);
			} else { return successor.readFrame(id, bytes, version); }
		}
		
		private function readPCNTFrame(bytes:ByteArray, version:Number):Frame {
			var frame:PCNTFrame = new PCNTFrame();
			var size:uint = ID3.readInt(bytes, version);
			ParseLog.debug(this, "size: {0} (+10)", size, bytes.position);
			readFlags( frame, bytes, version );
			if(frame.compression){
				size = uncompressFrame(size, bytes);
				ParseLog.parsed(this, "uncompressed size: {0} (+10)", size, bytes.position);
			}
			frame.counter = bytes.readUnsignedInt();
			ParseLog.parsed(this, "counter: {0}", frame.counter, bytes.position);
			return frame;
		}
	}
}