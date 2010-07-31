package com.metaphile.id3.frames
{
	import flash.utils.ByteArray;
	
	public class PRIVFrame extends Frame
	{
		
		override public function get type():uint {
			return FrameTypes.PRIVATE_FRAME;
		}
		
		private var _owner:String = "";
		public function get owner():String {
			return _owner;
		}
		public function set owner( value:String ):void {
			_owner = value;
		}
		
		private var _data:ByteArray = new ByteArray();
		public function get data():ByteArray {
			return _data;
		}
		public function set data( value:ByteArray ):void {
			_data = value;
		}
	}
}