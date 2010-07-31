package com.metaphile.id3.frames
{
	
	import flash.utils.ByteArray;
	
	public class GEOBFrame extends Frame
	{
		
		override public function get type():uint {
			return FrameTypes.GENERAL_ENCAPSULATED_OBJECT;
		}
		
		private var _encoding:int = 0;
		public function get encoding():int {
			return _encoding;
		}
		public function set encoding( value:int ):void {
			_encoding = value;
		}
		
		private var _mime:String;
		public function get mime():String {
			return _mime;
		}
		public function set mime( value:String ):void {
			_mime = value;
		}
		
		private var _objectType:uint;
		public function get objectType():uint {
			return _objectType;
		}
		public function set objectType( value:uint ):void {
			_objectType = value;
		}
		
		private var _filename:String = "";
		public function get filename():String {
			return _filename;
		}
		public function set filename( value:String ):void {
			_filename = value;
		}
		
		private var _description:String = "";
		public function get description():String {
			return _description;
		}
		public function set description( value:String ):void {
			_description = value;
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