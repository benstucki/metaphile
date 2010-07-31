package com.metaphile.id3.frames
{
	public class IPLSFrame extends Frame
	{
		
		override public function get type():uint {
			return FrameTypes.INVOLVED_PEOPLE_LIST;
		}
		
		private var _encoding:int = 0;
		public function get encoding():int {
			return _encoding;
		}
		public function set encoding( value:int ):void {
			_encoding = value;
		}
		
		private var _list:Array = new Array();
		public function get list():Array {
			return _list;
		}
		public function set list(value:Array):void {
			_list = value;
		}
		
	}
}