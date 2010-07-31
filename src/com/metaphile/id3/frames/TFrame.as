package com.metaphile.id3.frames
{
	
	//import flash.utils.IExternalizable;
	//import flash.utils.IDataInput;
	//import com.metaphile.logging.ParseLog;
	//import com.metaphile.id3.utilities.ID3;
	//import flash.utils.IDataOutput;
	
	
	/**
	 * The TFrame class represents any text frame in an ID3 tag except for the user defined TXXX frame.
	 */
	public class TFrame extends Frame
	{
		
		public function TFrame( type:uint, id:String=null ) {
			this.type = type;
		}
		
		private var _type:uint = FrameTypes.UNKNOWN;
		override public function get type():uint { return _type; }
		public function set type( value:uint ):void {
			_type = value;
		}
		
		private var _encoding:int = 0;
		public function get encoding():int { return _encoding; }
		public function set encoding( value:int ):void {
			_encoding = value;
		}
		
		private var _text:String = "";
		public function get text():String { return _text; }
		public function set text( value:String ):void {
			_text = value;
		}
		
		public function toString():String {
			return text;
		}
		
	}
}