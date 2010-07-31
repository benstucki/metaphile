package com.metaphile.utils
{
	import flash.utils.IDataInput;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class ByteUtil
	{
		
		public static function readBytes(stream:IDataInput):ByteArray {
			var endian:String = stream.endian;
			stream.endian = Endian.BIG_ENDIAN;
			var bytes:ByteArray = new ByteArray();
			while (stream.bytesAvailable > 3) {
				bytes.writeUnsignedInt(stream.readUnsignedInt());
			}
			while(stream.bytesAvailable > 0) {
				bytes.writeByte(stream.readUnsignedByte());
			}
			bytes.endian = endian;
			return bytes;
		}
		
	}
}