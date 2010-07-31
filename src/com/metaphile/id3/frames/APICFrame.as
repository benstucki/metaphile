package com.metaphile.id3.frames
{
	
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	
	public class APICFrame extends Frame
	{
		
		private var _encoding:int;
		private var _mime:String;
		private var _format:int;
		private var _description:String;
		private var _data:ByteArray;
		private var _image:Sprite;
		
		override public function get type():uint { return FrameTypes.ATTACHED_PICTURE; }
		
		public function get encoding():int { return _encoding; }
		public function set encoding( value:int ):void {
			_encoding = value;
		}
		
		public function get mime():String { return _mime; }
		public function set mime( value:String ):void {
			_mime = value;
		}
		
		// type???
		public function get format():int { return _format; }
		public function set format( value:int ):void {
			_format = value;
		}
		
		public function get description():String { return _description; }
		public function set description( value:String ):void {
			_description = value;
		}
		
		public function get image():ByteArray { return _data; }
		public function set image( value:ByteArray ):void {
			if(value.length>0) {
				_data = new ByteArray();
				value.position = 0;
				value.readBytes(_data);
				_image = null;
			}
		}
		
		/*
		[Bindable]
		public function get image():DisplayObject {
			if(_image==null) {
				var sprite:Sprite = new Sprite();
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
				loader.loadBytes(_data);
				_image = sprite;
			}
			return _image;
		}
		public function set image( value:DisplayObject ):void {
			//_image = value;
		}
		
		private function completeHandler( event:Event ):void {
			var loader:LoaderInfo = LoaderInfo(event.currentTarget);
			loader.removeEventListener(Event.COMPLETE, completeHandler);
			_image.addChild(loader.content);
		}
		*/
		
	}
}