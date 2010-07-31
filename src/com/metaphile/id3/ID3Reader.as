package com.metaphile.id3
{
	
	import flash.events.*;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	//import mx.controls.Image;
	import com.metaphile.*;
	import com.metaphile.id3.*;
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.parsers.*;
	import com.metaphile.id3.utilities.*;
	import flash.utils.Timer;
	import flash.utils.IDataInput;
	import com.metaphile.logging.ParseLog;
	import com.metaphile.IMetaData;
	import com.metaphile.IMetaReader;
	//import com.metaphile.MetaEvent;
	import flash.utils.Dictionary;
	
	public class ID3Reader extends MetaReaderBase implements IMetaReader {
		
		private var tags:Dictionary = new Dictionary(false);
		
		private var headerSize:uint = 10;
		/*
		public function get headerSize():uint {
			return 10;
		}
		*/
		private var chain:Array = [FrameParser, PRIVParser, GEOBParser, IPLSParser, PCNTParser, POPMParser, APICParser, COMMParser, WXXXParser, WParser, TXXXParser, TParser];
		private var parser:FrameParser;
		
		public function ID3Reader():void {
			linkChain();
		}
		
		public function read( stream:IDataInput ):void {
			if(stream is EventDispatcher) {
				(stream as EventDispatcher).addEventListener(ProgressEvent.PROGRESS, progressHandler);
			}
			if(stream.bytesAvailable > headerSize) {
				workStream(stream, stream.bytesAvailable, int.MAX_VALUE);
			}
		}
		
		private function parseHeader( bytes:IDataInput ):ID3Data {
			//var result:uint = 0;
			var tag:ID3Data = new ID3Data();
			if( bytes.bytesAvailable >= 10) {
				ParseLog.info(this, "## ID3v2 Header #############################################");
				if (bytes.readUTFBytes(3)=="ID3") {
					ParseLog.parsed(this, "id: {0}", "ID3", 3);
					tag.version = 2; // tag version
					tag.version += bytes.readByte()/10; // release
					tag.version += bytes.readByte()/100; // revision
					ParseLog.parsed(this, "version: {0}", tag.version, 5);
					//frameIdSize = tag.version < 2.3 ? 3 : 4;
					var flags:uint = bytes.readUnsignedByte(); // flags byte
					ParseLog.parsed(this, "read flags: {0}", flags.toString(2), 6);
					tag.unsynchronisation = Boolean(flags>>7);
					ParseLog.debug(this, "unsyncronization: {0}", tag.unsynchronisation);
					tag.extended = Boolean(flags>>6&01);
					ParseLog.debug(this, "extended: {0}", tag.extended);
					tag.experimental = Boolean(flags>>5&001);
					ParseLog.debug(this, "experimental: {0}", tag.experimental);
					var tagSize:int = ID3.convertSynchsafe(bytes.readUnsignedInt()); // tag size in byte
					ParseLog.parsed(this, "size: {0} (+10)", tagSize, 10);
					tag.size = tagSize - 10;
				} else {
					tag.version = 1;
					tag.size = int.MAX_VALUE;
				}
			}
			return tag;
		}
		
		private function parseBody( bytes:ByteArray, tag:ID3Data ):IMetaData {
			//var result:ID3Data = new ID3Data();
			//data.readBytes(_bytes,0);
			if(tag.version > 2){
				if(tag.unsynchronisation){
					bytes = ID3.unsynchronize(bytes);
					tag.size = bytes.length;
					ParseLog.debug(this, "unsynchronized size: {0}", tag.size);
				}
				if(tag.extended && tag.version>=2.3){
					ParseLog.debug(this, "extended header");
					var size:int = ID3.convertSynchsafe(bytes.readUnsignedInt());
					ParseLog.parsed(this, "size: {0}", size, bytes.position);
					var flags:int = bytes.readByte();
					ParseLog.parsed(this, "flags {0}", flags.toString(2), bytes.position);
					flags = bytes.readByte();
					ParseLog.parsed(this, "flags {0}", flags.toString(2), bytes.position);
					var paddingsize:int = ID3.convertSynchsafe(bytes.readUnsignedInt());
					ParseLog.parsed(this, "padding size: {0}", paddingsize, bytes.position);
				}
				var frameIdSize:Number = tag.version < 2.3 ? 3 : 4;
				var id:String = "";
				while(bytes.position < tag.size - frameIdSize){
					ParseLog.info(this, "////////////////////////////////////////////////////////////");
					
					id = bytes.readUTFBytes(frameIdSize);
					if( id=="" ) { 
						validatePadding(bytes);
						break;
					}
					ParseLog.parsed(this, "frame {0}", id, bytes.position);
					tag.addFrame( parser.readFrame(id, bytes, tag.version) );
				}
				ParseLog.info(this, "#############################################################");
			} else {
				
				bytes.position = bytes.length - 128;
				if(bytes.readUTFBytes(3)=="TAG"){
					ParseLog.info(this, "## ID3v1 ####################################################");
					var title:TFrame = new TFrame(FrameTypes.TITLE);
					title.text = bytes.readUTFBytes(30);
					tag.addFrame(title);
					ParseLog.parsed(this, "Title: {0)", title.text, bytes.position);
					var artist:TFrame = new TFrame(FrameTypes.BAND);
					artist.text = bytes.readUTFBytes(30);
					tag.addFrame(artist);
					ParseLog.parsed(this, "Artist: {0}", artist.text, bytes.position);
					var album:TFrame = new TFrame(FrameTypes.ALBUM_TITLE);
					album.text = bytes.readUTFBytes(30);
					tag.addFrame(album);
					ParseLog.parsed(this, "Album: {0}", album.text, bytes.position);
					var year:TFrame = new TFrame(FrameTypes.YEAR);
					year.text = bytes.readUTFBytes(4);
					tag.addFrame(year);
					ParseLog.parsed(this, "Year: {0}", year.text, bytes.position);
					var comment:TFrame = new TFrame(FrameTypes.COMMENTS);
					comment.text = bytes.readUTFBytes(30);
					tag.addFrame(comment);
					ParseLog.parsed(this, "Comments: {0}", comment.text, bytes.position);
					ParseLog.info(this, "#############################################################");
				} else {
					ParseLog.warn(this, "ID3 Not Found");
				}
			}
			return tag;
		}
		
		private function workStream(stream:IDataInput, bytesLoaded:int, bytesTotal:int):void {
			
			if( bytesLoaded > autoLimit && autoLimit > -1 ) {
				//stream.close();
			} else {
				var tag:ID3Data = tags[stream];
				var metaSize:int = tag!=null ? tag.size+10 : 0;
				var bytes:ByteArray = new ByteArray();
				if( bytesLoaded >= headerSize && metaSize == 0) {
					stream.readBytes(bytes, 0, headerSize);
					tag = parseHeader( bytes );
					tags[stream] = tag; 
					metaSize = Math.min(bytesTotal, tag.size+10);
					if(bytesLoaded >= metaSize) { workStream(stream, bytesLoaded, bytesTotal); }
				} else if ( bytesLoaded >= metaSize && metaSize > 0 ) {
					stream.readBytes(bytes, 0, metaSize );
					if(stream is EventDispatcher) {
						(stream as EventDispatcher).removeEventListener(ProgressEvent.PROGRESS, progressHandler);
					}
					if(autoClose && (stream as Object).hasOwnProperty("close")) {
						(stream as Object).close();
					}
					onMetaData(parseBody( bytes, tag ));
				}
			}
		}
		
		private function progressHandler(event:ProgressEvent):void {
			workStream((event.target as IDataInput), event.bytesLoaded, event.bytesTotal);
		}
		
		// utility functions
		
		private function validatePadding( bytes:ByteArray ):void {
			var l:uint = bytes.length;
			var start:int = bytes.position;
			while(bytes.readByte()==0 && bytes.position < l) {}
			var end:int = bytes.position;
			ParseLog.parsed(this, "padding", "", bytes.position);
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