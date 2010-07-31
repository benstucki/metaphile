package com.metaphile.utils
{
	import flash.utils.IDataInput;
	
	/**
	 * assists in reading packed bits, currently must be used forward only.
	 * issues... 24 to 32 bit reads with buffer will misread
	 */
	public class BitReader
	{
		
		private var buffer:uint = 0;
		private var overflow:uint = 0;
		
		public function readUnsignedInt(stream:IDataInput, length:uint):uint {
			var count:uint = overflow;
			var result:uint = buffer;
			var b:uint = 0
			while(count<length) {
				b = stream.readUnsignedByte();
				result = result << 8 | b;
				count += 8;
			}
			overflow = count - length;
			buffer = b << (32-overflow) >>> (32-overflow);
			result = result >> overflow;
			return result;
		}
		
		public function flush():uint {
			var result:uint = buffer;
			buffer = 0;
			overflow = 0;
			return result;
		}
		
	}
}