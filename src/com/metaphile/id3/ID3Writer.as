package com.metaphile.id3
{
	import flash.events.EventDispatcher;
	import com.metaphile.IMetaWriter;
	import com.metaphile.IMetaData;
	import flash.utils.ByteArray;
	import flash.utils.IDataOutput;
	import com.metaphile.id3.parsers.*;
	
	public class ID3Writer extends EventDispatcher implements IMetaWriter
	{
		
		private var chain:Array = [FrameParser, PRIVParser, GEOBParser, IPLSParser, PCNTParser, POPMParser, APICParser, COMMParser, WXXXParser, WParser, TXXXParser, TParser];
		private var parser:FrameParser;
		
		public function ID3Writer():void {
			linkChain();
		}
		
		public function encode(meta:IMetaData):ByteArray {
			// generalize later
			var bytes:ByteArray = new ByteArray();
			if(meta is ID3Data) {
				writeHeader(meta as ID3Data, bytes);
				writeBody(meta as ID3Data, bytes);
			}
			return bytes;
		}
		
		private function writeHeader(id3:ID3Data, stream:IDataOutput):void {
			if(id3.version >= 2) {
				stream.writeUTF("I");
				stream.writeUTF("D");
				stream.writeUTF("3");
				stream.writeByte(3); // release
				stream.writeByte(0); // revision
				stream.writeByte(0); // flags
				stream.writeInt(10);
			}
		}
		
		private function writeBody(id3:ID3Data, stream:IDataOutput):void {
			
		}
		
		private function linkChain():void {
			var lastLink:FrameParser = null;
			for each(var prototype:Class in chain){
				var link:FrameParser = new prototype( lastLink );
				lastLink = link;
			}
			parser = lastLink;
		}
		
	}
}