package com.metaphile.id3.parsers
{
	import com.metaphile.id3.*;
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.utilities.*;
	import com.metaphile.logging.*;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class APICParser extends FrameParser
	{
		
		CONFIG::debugging { private var logger:ILogger = Log.getLogger(flash.utils.getQualifiedClassName(this).replace("::", ".")); }
		
		public function APICParser( successor:FrameParser  ) {
			super(successor);
		}
		
		override public function readFrame(id:String, bytes:ByteArray, version:Number):Frame {
			if(id=="APIC" || id=="PIC") {
				return readAPICFrame(bytes, version);
			} else { return successor.readFrame(id, bytes, version); }
		}
		
		private function readAPICFrame( bytes:ByteArray, version:Number ):Frame {
			var frame:APICFrame = new APICFrame();
			var size:int = ID3.readInt(bytes, version);
			CONFIG::debugging { logger.info("size: {0} (+10)", size, bytes.position); }
			var data:ByteArray = new ByteArray();
			readFlags( frame, bytes, version );
			if(frame.compression){
				size = uncompressFrame(size, bytes);
				CONFIG::debugging { logger.info("uncompressed size: {0} (+10)", size); }
			}
			var start:uint = bytes.position;
			frame.encoding = bytes.readUnsignedByte();
			CONFIG::debugging { logger.info("encoding: {0}", frame.encoding, bytes.position); }
			if(version > 2.2) {
				frame.mime = ID3.readString(bytes, frame.encoding);
			} else { frame.mime = bytes.readUTFBytes(3); }
			CONFIG::debugging { logger.info("mime: {0}", frame.mime, bytes.position); }
			frame.format = bytes.readUnsignedByte();
			CONFIG::debugging { logger.info("type: {0}", frame.format, bytes.position); }
			frame.description = ID3.readString(bytes, frame.encoding);
			CONFIG::debugging { logger.info("description: {0}", frame.description, bytes.position); }
			var imageSize:uint = size-(bytes.position-start);
			CONFIG::debugging { logger.info("( image size = {0} )", imageSize); }
			if(imageSize > 0) { bytes.readBytes(data,0,imageSize); }
			CONFIG::debugging { logger.info("read image", "", bytes.position); }
			frame.image = data;
			return frame;
		}
		
		override public function getSize(frame:Frame, version:Number):uint {
			if(frame is APICFrame) {
				var apic:APICFrame = frame as APICFrame;
				switch(version) {
					case 2.2:
						return 3 + 3 + 1 + apic.mime.length + 2 + 1 + apic.description.length + 2 + apic.image.length;
						break;
					case 2.3:
						return 4 + 4 + 1 + apic.mime.length + 2 + 1 + apic.description.length + 2 + apic.image.length;
						break;
				}
			}
			return 0;
		}
		
	}
}