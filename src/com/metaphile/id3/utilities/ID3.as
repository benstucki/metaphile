package com.metaphile.id3.utilities
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	
	public class ID3
	{
		/*
		public static function skipLength( bytes:ByteArray, length:uint):void {
			for(var i:uint=0;i<length;i++) {
				bytes.readByte();
			}
		}
		*/
		
		public static function convertSynchsafe( value:uint ):uint {
			return (value & 127) + 128 * ((value >> 8) & 127) + 16384 * ((value >>16) & 127) + 2097152 * ((value >> 24) & 127);
		}
		
		public static function readInt(stream:IDataInput, version:Number):uint {
			switch(version) {
				case 2.2:
					var b1:int = stream.readUnsignedByte();
					var b2:int = stream.readUnsignedByte();
					var b3:int = stream.readUnsignedByte();
					return (b1 << 16) | (b2 << 8) | b3;
				default:
					return stream.readInt();
					break;
			}
		}
		
		public static function readString( bytes:IDataInput, encoding:int=0, limit:uint=uint.MAX_VALUE ):String {
			var response:String = ""
			switch(encoding){
				case 1:
				case 2:
					response = readUnicode(bytes, limit);
					break;
				default:
					response = readISO(bytes, limit);
					break;
			}
			return response;
		}
		
		private static function readISO( bytes:IDataInput, limit:uint=uint.MAX_VALUE ):String {
			var ba:ByteArray = new ByteArray();
			var b:uint = 1;
			while(b != 0x00 && ba.length<limit) {
				b = bytes.readUnsignedByte();
				ba.writeByte(b);
			}
			ba.position = 0;
			return ba.readUTFBytes(ba.length);
		}
		
		private static function readUnicode( bytes:IDataInput, limit:uint=uint.MAX_VALUE):String {
			var ba:ByteArray = new ByteArray();
			var b2:uint = bytes.readUnsignedShort();
			while(b2 != 0x0000 && ba.length*2+2<limit) {
				b2 = bytes.readUnsignedShort();
				ba.writeByte(b2>>8); // nasty hack
			}
			ba.position = 0;
			return ba.readMultiByte(ba.length, "utf-8"); // no utf-16 support
		}
		
		public static function unsynchronize( bytes:IDataInput ):ByteArray {
			var i:int = bytes.bytesAvailable;
			var newBytes:ByteArray = new ByteArray();
			var lastByte:uint = 0;
			while(i-->0){
				var thisByte:uint = bytes.readUnsignedByte();
				if(!(lastByte==0xFF && thisByte==0x00)){
					newBytes.writeByte(thisByte);
				} else { /*trace(lastByte.toString(2) + " " + thisByte.toString(2));*/ }
				lastByte = thisByte;
			}
			newBytes.position = 0;
			return newBytes;
		}
		
	}
}