package com.metaphile.id3.frames
{
	public class WFrame extends Frame
	{
		
		private var _type:uint = FrameTypes.UNKNOWN;
		override public function get type():uint {
			return _type;
		}
		
		private var _url:String;
		public function get url():String {
			return _url;
		}
		public function set url( value:String ):void {
			_url = value;
		}
		
		public function WFrame( type:uint ):void {
			_type = type;
		}
		
	}
}