package com.metaphile.swf
{
	import com.metaphile.IMetaData;
	
	public class SWFData
	{
		
		private var _width:Number;
		public function get width():Number { return _width; }
		public function set width(value:Number):void {
			_width = value;
		}
		
		private var _height:Number;
		public function get height():Number { return _height; }
		public function set height(value:Number):void {
			_height = value;
		}
		
		private var _version:Number;
		public function get version():Number { return _version; }
		public function set version(value:Number):void {
			_version = value;
		}
		
		private var _fps:Number;
		public function get fps():Number { return _fps; }
		public function set fps(value:Number):void {
			_fps = value;
		}
		
		private var _frames:uint;
		public function get frames():uint { return _frames; }
		public function set frames(value:uint):void {
			_frames = value;
		}
		
	}
}