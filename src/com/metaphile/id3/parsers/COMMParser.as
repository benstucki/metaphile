package com.metaphile.id3.parsers
{
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.utilities.*;
	import com.metaphile.id3.*;
	import flash.utils.ByteArray;
	import com.metaphile.logging.ParseLog;
	
	public class COMMParser extends FrameParser
	{
		
		public function COMMParser( successor:FrameParser = null ) {
			super( successor );
		}
		
		override public function readFrame(id:String, bytes:ByteArray, version:Number):Frame {
			if(id=="COMM" || id=="COM") {
				return readCOMMFrame(bytes, version);
			} else { return successor.readFrame(id, bytes, version); }
		}
		
		private function readCOMMFrame(bytes:ByteArray, version:Number = 2.3):Frame {
			var frame:COMMFrame = new COMMFrame();
			var size:uint = ID3.readInt(bytes, version);
			ParseLog.parsed(this, "size: {0} (+10)", size, bytes.position);
			readFlags( frame, bytes, version );
			if(frame.compression){
				size = uncompressFrame(size, bytes);
				ParseLog.parsed(this, "uncompressed size: {0} (+10)", size.toString(), bytes.position);
			}
			var start:uint = bytes.position;
			frame.encoding = bytes.readUnsignedByte();
			ParseLog.parsed(this, "encoding: {0}", frame.encoding, bytes.position);
			frame.language = ID3.readString(bytes, 0, 3);
			ParseLog.parsed(this, "language: {0}", frame.language, bytes.position);
			frame.description = ID3.readString(bytes, frame.encoding);
			ParseLog.parsed(this, "description: {0}", frame.description, bytes.position);
			frame.text = ID3.readString(bytes, frame.encoding, size - (bytes.position - start));
			ParseLog.parsed(this, "text: {0}", frame.text, bytes.position);
			return frame;
		}
		
		override public function getSize(frame:Frame, version:Number):uint {
			if(frame is COMMFrame) {
				var comm:COMMFrame = frame as COMMFrame;
				switch(version) {
					case 2.2:
						return 3 + 3 + 1 + comm.language.length + 2 + comm.description.length + 2 + comm.text.length;
						break;
					case 2.3:
						return 4 + 4 + 1 + comm.language.length + 2 + comm.description.length + 2 + comm.text.length;
						break;
				}
			}
			return 0;
		}
		
	}
}