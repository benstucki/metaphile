package com.metaphile.id3.frames
{
	public class POPMFrame extends Frame
	{
		override public function get type():uint {
			return FrameTypes.POPULARIMETER;
		}
		
		private var _user:String = "";
		public function get user():String { return _user; }
		public function set user( value:String ):void { _user = value; }
		
		private var _rating:uint = 0;
		public function get rating():uint { return _rating; }
		public function set rating( value:uint ):void { _rating = value; }
		
		private var _counter:uint = 0;
		public function get counter():uint { return _counter; }
		public function set counter( value:uint ):void { _counter = value; }
		
	}
}