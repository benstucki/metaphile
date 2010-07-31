package com.metaphile.id3.frames
{
	public class PCNTFrame extends Frame
	{
		override public function get type():uint {
			return FrameTypes.PLAY_COUNTER;
		}
		
		private var _counter:uint = 0;
		public function get counter():uint { return _counter; }
		public function set counter( value:uint ):void { _counter = value; }
		
	}
}