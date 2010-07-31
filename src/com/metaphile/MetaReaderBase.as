package com.metaphile
{
	
	public class MetaReaderBase
	{
		
		private var _autoClose:Boolean;
		private var _autoLimit:int;
		private var _onMetaData:Function;
		
		public function get autoClose():Boolean { return _autoClose; }
		public function set autoClose(value:Boolean):void {
			_autoClose = value;
		}
		
		
		public function get autoLimit():int { return _autoLimit; }
		public function set autoLimit(value:int):void {
			_autoLimit = value;
		}
		
		
		public function get onMetaData():Function { return _onMetaData; }
		public function set onMetaData(value:Function):void {
			_onMetaData = value;
		}
		
	}
}