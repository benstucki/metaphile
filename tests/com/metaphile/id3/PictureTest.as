package com.metaphile.id3
{
	
	import com.metaphile.id3.ID3Reader;
	import com.metaphile.id3.frames.APICFrame;
	
	import flash.utils.ByteArray;
	
	import mx.core.ByteArrayAsset;
	import mx.logging.ILoggingTarget;
	import mx.logging.Log;
	import mx.logging.targets.TraceTarget;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.utils.Base64Encoder;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	public class PictureTest
	{
		
		[Embed(source="//com/metaphile/id3/id3libtags/230-picture.tag", mimeType="application/octet-stream")]
		private static const TestTag:Class;
		
		[Embed(source="//com/metaphile/id3/id3libtags/composer.jpg", mimeType="application/octet-stream")]
		private static const TestImage:Class;
		
		[Test(async)]
		public function pictureTest():void {
			var responder:IResponder = new Responder(onMetaData, fault);
			responder = Async.asyncResponder(this, responder, 1000, null, timeoutHandler);
			var bytes:ByteArray = new TestTag();
			var parser:ID3Reader = new ID3Reader();
			parser.autoLimit = 100000;
			parser.onMetaData = responder.result;
			parser.read(bytes);
		}
		
		private function onMetaData(id3:ID3Data):void {
			var frame:APICFrame = id3.frames[8];
			var image:ByteArray = new TestImage();
			
			var encoder:Base64Encoder = new Base64Encoder();
			encoder.encodeBytes(frame.image);
			var frameString:String = encoder.flush();
			encoder.encodeBytes(image);
			var imageString:String = encoder.flush();
			
			Assert.assertStrictlyEquals(frameString, imageString);
		}
		
		private function fault(id3:Object):void {
			Assert.fail("fault.");
		}
		
		private function timeoutHandler():void {
			Assert.fail("test timed out.");
		}
		
	}
}