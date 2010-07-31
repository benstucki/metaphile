package com.metaphile.id3.parsers
{
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.utilities.*;
	import com.metaphile.id3.*;
	import flash.utils.ByteArray;
	import com.metaphile.logging.ParseLog;
	
	public class IPLSParser extends FrameParser
	{
		
		public function IPLSParser( successor:FrameParser = null ):void {
			super( successor );
		}
		
		override public function readFrame(id:String, bytes:ByteArray, version:Number):Frame {
			if(id=="IPLS" || id=="IPL") {
				return readIPLSFrame(bytes, version);
			} else { return successor.readFrame(id, bytes, version); }
		}
		
		private function readIPLSFrame(bytes:ByteArray, version:Number = 2.3):Frame {
			var frame:IPLSFrame = new IPLSFrame();
			var size:int = ID3.readInt(bytes, version);
			ParseLog.parsed(this, "size: {0} (+10)", size, bytes.position);
			readFlags( frame, bytes, version );
			if(frame.compression){
				size = uncompressFrame(size, bytes);
				ParseLog.parsed(this, "uncompressed size: {0} (+10)", size, bytes.position);
			}
			var start:uint = bytes.position;
			frame.encoding = bytes.readUnsignedByte();
			while(bytes.position < start + size) {
				var involvement:Array = new Array();
				involvement.push(ID3.readString(bytes, frame.encoding, size-(bytes.position - start)));
				involvement.push(ID3.readString(bytes, frame.encoding, size-(bytes.position - start)));
				ParseLog.parsed(this, involvement[0] + ": {0}", involvement[1], bytes.position);
				frame.list.push(involvement);
			}
			return frame;
		}
	}
}