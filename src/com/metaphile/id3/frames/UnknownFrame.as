package com.metaphile.id3.frames
{
	import flash.utils.ByteArray;
	
	public class UnknownFrame extends Frame
	{
		private var _data:ByteArray;
		public function get data():ByteArray {
			return _data;
		}
		public function set data( value:ByteArray ):void {
			_data = value;
		}
	}
}