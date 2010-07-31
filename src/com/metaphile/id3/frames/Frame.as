package com.metaphile.id3.frames
{
	//import flash.utils.IDataInput;
	//import flash.utils.ByteArray;
	//import com.metaphile.logging.ParseLog;
	
	/**
	 * The ID3Frame is intended as the base class for all ID3 frame objects
	 */
	public class Frame
	{
		
		private var version:Number;
		
		public function get type():uint { return FrameTypes.UNKNOWN; }
		
		private var _tagAlterPreservation:Boolean;
		public function get tagAlterPreservation():Boolean { return _tagAlterPreservation; }
		public function set tagAlterPreservation( value:Boolean ):void {
			_tagAlterPreservation = value;
		}
		
		private var _fileAlterPreservation:Boolean;
		public function get fileAlterPreservation():Boolean { return _fileAlterPreservation; }
		public function set fileAlterPreservation( value:Boolean ):void {
			_fileAlterPreservation = value;
		}
		
		private var _readOnly:Boolean;
		public function get readOnly():Boolean { return _readOnly; }
		public function set readOnly( value:Boolean ):void {
			_readOnly = value;
		}
		
		private var _compression:Boolean;
		public function get compression():Boolean { return _compression; }
		public function set compression( value:Boolean ):void {
			_compression = value;
		}
		
		private var _encryption:Boolean;
		public function get encryption():Boolean { return _encryption; }
		public function set encryption( value:Boolean ):void {
			_encryption = value;
		}
		
		private var _grouping:Boolean;
		public function get grouping():Boolean { return _grouping; }
		public function set grouping( value:Boolean ):void {
			_grouping = value;
		}
		
		/*
		protected function readFlags( input:IDataInput ):void {
			if (version >= 2.3) {
				var flags:uint = input.readUnsignedByte();
				ParseLog.parsed(this, "status flags", flags.toString(2), 1);
				tagAlterPreservation = Boolean(flags>>7);
				ParseLog.debug(this, "tag alter preservation: {0}", tagAlterPreservation);
				fileAlterPreservation = Boolean(flags>>6&01);
				ParseLog.debug(this, "file alter preservation: {0}", fileAlterPreservation);
				readOnly = Boolean(flags>>5&001);
				ParseLog.debug(this, "read only: {0}", readOnly);
				flags = input.readUnsignedByte();
				ParseLog.parsed(this, "encoding flags", flags.toString(2), 1);
				compression = Boolean(flags>>7);
				ParseLog.debug(this, "compression: {0}", compression);
				encryption = Boolean(flags>>6&01);
				ParseLog.debug(this, "encryption: {0}", encryption);
				grouping = Boolean(flags>>5&001);
				ParseLog.debug(this, "grouping: {0}", grouping);
			}
		}
		*//*
		protected function uncompress( input:IDataInput, size:uint ):ByteArray {
			var uncompressedSize:uint = input.readUnsignedInt();
			var temp:ByteArray = new ByteArray();
			input.readBytes(temp, 0, size-4);
			temp.uncompress();
			temp.position = 0;
			return temp;
		}
		*/
	}
}