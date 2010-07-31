package com.metaphile.id3
{
	
	import com.metaphile.*;
	import com.metaphile.IMetaData;
	import com.metaphile.IMetaReader;
	import com.metaphile.id3.*;
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.parsers.*;
	import com.metaphile.id3.utilities.*;
	
	import flash.events.*;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
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
		
		CONFIG::debugging { private var logger:ILogger = Log.getLogger(flash.utils.getQualifiedClassName(this).replace("::", ".")); }
		
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
				CONFIG::debugging { logger.info("## ID3v2 Header #############################################"); }
				if (bytes.readUTFBytes(3)=="ID3") {
					CONFIG::debugging { logger.info("id: {0}", "ID3", 3); }
					tag.version = 2; // tag version
					tag.version += bytes.readByte()/10; // release
					tag.version += bytes.readByte()/100; // revision
					CONFIG::debugging { logger.info("version: {0}", tag.version, 5); }
					//frameIdSize = tag.version < 2.3 ? 3 : 4;
					var flags:uint = bytes.readUnsignedByte(); // flags byte
					CONFIG::debugging { logger.info("read flags: {0}", flags.toString(2), 6); }
					tag.unsynchronisation = Boolean(flags>>7);
					CONFIG::debugging { logger.info("unsyncronization: {0}", tag.unsynchronisation); }
					tag.extended = Boolean(flags>>6&01);
					CONFIG::debugging { logger.info("extended: {0}", tag.extended); }
					tag.experimental = Boolean(flags>>5&001);
					CONFIG::debugging { logger.info("experimental: {0}", tag.experimental); }
					var tagSize:int = ID3.convertSynchsafe(bytes.readUnsignedInt()); // tag size in byte
					CONFIG::debugging { logger.info("size: {0} (+10)", tagSize, 10); }
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
			var frames:Array = [];
			if(tag.version > 2){
				if(tag.unsynchronisation){
					bytes = ID3.unsynchronize(bytes);
					tag.size = bytes.length;
					CONFIG::debugging { logger.info("unsynchronized size: {0}", tag.size); }
				}
				if(tag.extended && tag.version>=2.3){
					CONFIG::debugging { logger.info("extended header"); }
					var size:int = ID3.convertSynchsafe(bytes.readUnsignedInt());
					CONFIG::debugging { logger.info("size: {0}", size, bytes.position); }
					var flags:int = bytes.readByte();
					CONFIG::debugging { logger.info("flags {0}", flags.toString(2), bytes.position); }
					flags = bytes.readByte();
					CONFIG::debugging { logger.info("flags {0}", flags.toString(2), bytes.position); }
					var paddingsize:int = ID3.convertSynchsafe(bytes.readUnsignedInt());
					CONFIG::debugging { logger.info("padding size: {0}", paddingsize, bytes.position); }
				}
				var frameIdSize:Number = tag.version < 2.3 ? 3 : 4;
				var id:String = "";
				while(bytes.position < tag.size - frameIdSize){
					CONFIG::debugging { logger.info("////////////////////////////////////////////////////////////"); }
					
					id = bytes.readUTFBytes(frameIdSize);
					if( id=="" ) { 
						validatePadding(bytes);
						break;
					}
					CONFIG::debugging { logger.info("frame {0}", id, bytes.position); }
					//tag.addFrame( parser.readFrame(id, bytes, tag.version) );
					frames.push( parser.readFrame(id, bytes, tag.version) );
				}
				tag.frames = frames;
				CONFIG::debugging { logger.info("#############################################################"); }
			} else {
				
				bytes.position = bytes.length - 128;
				if(bytes.readUTFBytes(3)=="TAG"){
					CONFIG::debugging { logger.info("## ID3v1 ####################################################"); }
					var title:TFrame = new TFrame(FrameTypes.TITLE);
					title.text = bytes.readUTFBytes(30);
					//tag.addFrame(title);
					frames.push(title);
					CONFIG::debugging { logger.info("Title: {0)", title.text, bytes.position); }
					var artist:TFrame = new TFrame(FrameTypes.BAND);
					artist.text = bytes.readUTFBytes(30);
					//tag.addFrame(artist);
					frames.push(artist);
					CONFIG::debugging { logger.info("Artist: {0}", artist.text, bytes.position); }
					var album:TFrame = new TFrame(FrameTypes.ALBUM_TITLE);
					album.text = bytes.readUTFBytes(30);
					//tag.addFrame(album);
					frames.push(album);
					CONFIG::debugging { logger.info("Album: {0}", album.text, bytes.position); }
					var year:TFrame = new TFrame(FrameTypes.YEAR);
					year.text = bytes.readUTFBytes(4);
					//tag.addFrame(year);
					frames.push(year);
					CONFIG::debugging { logger.info("Year: {0}", year.text, bytes.position); }
					var comment:TFrame = new TFrame(FrameTypes.COMMENTS);
					comment.text = bytes.readUTFBytes(30);
					//tag.addFrame(comment);
					frames.push(comment);
					CONFIG::debugging { logger.info("Comments: {0}", comment.text, bytes.position); }
					tag.frames = frames;
					CONFIG::debugging { logger.info("#############################################################"); }
				} else {
					CONFIG::debugging { logger.warn("ID3 Not Found"); }
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
			CONFIG::debugging { logger.info("padding", "", bytes.position); }
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