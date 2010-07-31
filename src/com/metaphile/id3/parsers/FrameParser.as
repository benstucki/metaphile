package com.metaphile.id3.parsers
{
	
	import flash.events.EventDispatcher;
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.*;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import mx.logging.*;
	import com.metaphile.logging.ParseLog;
	import com.metaphile.id3.utilities.ID3;
	
	/**
	 * FrameParser is the base class for all ID3 frame parsers.
	 * It provides common functionality for reading header flags and uncompressing frame data.
	 */
	public class FrameParser extends EventDispatcher
	{
		
		private var _successor:FrameParser = null;
		public function get successor():FrameParser { return _successor; }
		
		public function FrameParser( successor:FrameParser = null ) {
			_successor = successor;
		}
		
		public function readFrame( id:String, bytes:ByteArray, version:Number ):Frame {
			var frame:UnknownFrame = new UnknownFrame();
			var size:int = ID3.readInt(bytes, version);
			ParseLog.parsed(this, "size: {0} (+10)", size, bytes.position);
			readFlags(frame, bytes, version);
			bytes.position += size;
			ParseLog.parsed(this, "skipped bytes", size, bytes.position);
			/*if(handler.tag.frames[FrameTypes.UNKNOWN]){
				handler.tag.frames[FrameTypes.UNKNOWN].push(frame);
			} else { handler.tag.frames[FrameTypes.UNKNOWN] = new Array(frame); }*/
			return frame;
		}
		
		/**
		 * Populates a given frame with standard data read from header flags
		 */
		protected function readFlags( frame:Frame, bytes:ByteArray, version:Number ):void {
			if (version >= 2.3) {
				var flags:uint = bytes.readUnsignedByte();
				ParseLog.parsed(this, "status flags", flags.toString(2), bytes.position);
				frame.tagAlterPreservation = Boolean(flags>>7);
				ParseLog.debug(this, "tag alter preservation: {0}", frame.tagAlterPreservation);
				frame.fileAlterPreservation = Boolean(flags>>6&01);
				ParseLog.debug(this, "file alter preservation: {0}", frame.fileAlterPreservation);
				frame.readOnly = Boolean(flags>>5&001);
				ParseLog.debug(this, "read only: {0}", frame.readOnly);
				flags = bytes.readUnsignedByte();
				ParseLog.parsed(this, "encoding flags", flags.toString(2), bytes.position);
				frame.compression = Boolean(flags>>7);
				ParseLog.debug(this, "compression: {0}", frame.compression);
				frame.encryption = Boolean(flags>>6&01);
				ParseLog.debug(this, "encryption: {0}", frame.encryption);
				frame.grouping = Boolean(flags>>5&001);
				ParseLog.debug(this, "grouping: {0}", frame.grouping);
			}
		}
		
		/**
		 * Uncompresses the current frame.
		 */
		protected function uncompressFrame(size:uint, bytes:ByteArray):uint {
			var result:uint = bytes.readUnsignedInt();
			var temp:ByteArray = new ByteArray();
			bytes.readBytes(temp, 0, size-4);
			temp.uncompress();
			//trace(result + " == " + bytes.length + " ?");
			//trace("handler.bytes.length = " + handler.bytes.length);
			bytes.writeBytes(temp, 0, temp.length);
			//trace("handler.bytes.length = " + handler.bytes.length);
			bytes.position -= temp.length;
			return result;
		}
		
		public function getSize(frame:Frame, version:Number):uint {
			return 0;
		}
		
	}
}