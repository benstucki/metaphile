package com.metaphile.id3.parsers
{
	import com.metaphile.logging.ParseLog;
	import com.metaphile.id3.frames.*;
	import com.metaphile.id3.utilities.*;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import com.metaphile.id3.ID3Data;
	
	public class TParser extends FrameParser
	{
		
		// holds defined id values for version 1, 2.2, 2.3, and 2.4 respectively.
		// (null if frame does not exist in version)
		private var relationships:Dictionary = new Dictionary();
		
		public function TParser( successor:FrameParser = null ) {
			super(successor);
			setRelationships();
		}
		
		override public function readFrame(id:String, bytes:ByteArray, version:Number):Frame {
			if(id.charAt(0)=="T") {
				var type:uint = getFrameType(id, version);
				//if(type!=FrameTypes.UNKNOWN){
					return readTFrame(type, bytes, version);
				//} else { return successor.readFrame(id, bytes, version); }
			} else { return successor.readFrame(id, bytes, version); }
		}
		
		// parsing functions
		
		private function readTFrame(type:uint, bytes:ByteArray, version:Number):Frame {
			var size:int = ID3.readInt(bytes, version);
			ParseLog.parsed(this, "size: {0} (+10)", size, bytes.position);
			var frame:TFrame = new TFrame( type );
			readFlags( frame, bytes, version );
			if(frame.compression){
				size = uncompressFrame(size, bytes);
				ParseLog.info(this, "uncompressed size {0} (+10)", size);
			}
			frame.encoding = bytes.readUnsignedByte();
			ParseLog.parsed(this, "encoding: {0}", frame.encoding, bytes.position);
			frame.text = ID3.readString(bytes, frame.encoding, size-1);
			ParseLog.parsed(this, "text: {0}", frame.text, bytes.position);
			//handler.tag.frames[type] = frame;
			return frame;
		}
		
		
		// frame specific helper functions
		
		private function setRelationships():void {
			relationships[FrameTypes.ALBUM_TITLE] = new Array("TAL", "TALB", "TALB");
			relationships[FrameTypes.BPM] = new Array("TBP", "TBPM", "TBPM");
			relationships[FrameTypes.COMPOSER] = new Array("TCM", "TCOM", "TCOM");
			relationships[FrameTypes.CONTENT_TYPE] = new Array("TCO", "TCON", "TCON"); // Content type
			relationships[FrameTypes.COPYRIGHT_MESSAGE] = new Array("TCR", "TCOP", "TCOP"); // Copyright message
			//relationships[FrameTypes.DATE] = new Array("TDA", 0, 0);
			relationships[FrameTypes.ENCODING_TIME] = new Array(null, null, "TDEN"); // Encoding time
			relationships[FrameTypes.PLAYLIST_DELAY] = new Array("TDY", "TDLY", "TDLY"); // Playlist delay
			relationships[FrameTypes.ORIGINAL_RELEASE_TIME] = new Array(null, null, "TDOR"); // Original release time
			relationships[FrameTypes.RECORDING_TIME] = new Array(null, null, "TDRC"); // Recording time
			relationships[FrameTypes.RELEASE_TIME] = new Array(null, null, "TDRL"); // Release time
			relationships[FrameTypes.TAGGING_TIME] = new Array(null, null, "TDTG"); // Tagging time
			relationships[FrameTypes.ENCODED_BY] = new Array("TEN", "TENC", "TENC"); // Encoded by
			relationships[FrameTypes.LYRICIST] = new Array("TXT", "TEXT", "TEXT"); // Lyricist/Text writer
			relationships[FrameTypes.FILE_TYPE] = new Array("TFT", "TFLT", "TFLT"); // File type
			//relationships[FrameTypes.TIME] = new Array("TIM", null, null);
			relationships[FrameTypes.INVOLVED_PEOPLE_LIST] = new Array(null, null, "TIPL"); // Involved people list
			relationships[FrameTypes.CONTENT_GROUP_DESCRIPTION] = new Array("TT1", "TIT1", "TIT1"); // Content group description
			relationships[FrameTypes.TITLE] = new Array("TT2", "TIT2", "TIT2"); // Title/songname/content description
			relationships[FrameTypes.SUBTITLE] = new Array("TT3", "TIT3", "TIT3"); // Subtitle/Description refinement
			relationships[FrameTypes.INITIAL_KEY] = new Array("TKE", "TKEY", "TKEY"); // Initial key
			relationships[FrameTypes.LANGUAGE] = new Array("TLA", "TLAN", "TLAN"); // Language(s)
			relationships[FrameTypes.LENGTH] = new Array("TLE", "TLEN", "TLEN"); // Length
			relationships[FrameTypes.MUSICIAN_CREDITS_LIST] = new Array(null, null, "TMCL"); // Musician credits list
			relationships[FrameTypes.MEDIA_TYPE] = new Array("TMT", "TMED", "TMED"); // Media type
			relationships[FrameTypes.MOOD] = new Array(null, null, "TMOO"); // Mood
			relationships[FrameTypes.ORIGINAL_ALBUM] = new Array("TOT", "TOAL", "TOAL"); // Original album/movie/show title
			relationships[FrameTypes.ORIGINAL_FILENAME] = new Array("TOF", "TOFN", "TOFN"); // Original filename
			relationships[FrameTypes.ORIGINAL_LYRICIST] = new Array("TOL", "TOLY", "TOLY"); // Original lyricist(s)/text writer(s)
			relationships[FrameTypes.ORIGINAL_ARTIST] = new Array("TOA", "TOPE", "TOPE"); // Original artist(s)/performer(s)
			//relationships[FrameTypes.ORIGINAL_RELEASE_YEAR] = new Array("TOR", 0, 0)
			relationships[FrameTypes.FILE_OWNER] = new Array(null, "TOWN", "TOWN"); // File owner/licensee
			relationships[FrameTypes.LEAD_PERFORMER] = new Array("TP1", "TPE1", "TPE1"); // Lead performer(s)/Soloist(s)
			relationships[FrameTypes.BAND] = new Array("TP2", "TPE2", "TPE2"); // Band/orchestra/accompaniment
			relationships[FrameTypes.CONDUCTOR] = new Array("TP3", "TPE3", "TPE3"); // Conductor/performer refinement
			relationships[FrameTypes.INTERPRETED_BY] = new Array("TP4", "TPE4", "TPE4"); // Interpreted, remixed, or otherwise modified by
			relationships[FrameTypes.PART_OF_SET] = new Array("TPA", "TPOS", "TPOS"); // Part of a set
			relationships[FrameTypes.PRODUCED_NOTICE] = new Array(null, null, "TPRO"); // Produced notice
			relationships[FrameTypes.PUBLISHER] = new Array("TPB", "TPUB", "TPUB"); // Publisher
			relationships[FrameTypes.TRACK_NUMBER] = new Array("TRK", "TRCK", "TRCK"); // Track number/Position in set
			relationships[FrameTypes.INTERNET_RADIO_STATION_NAME] = new Array(null, "TRSN", "TRSN"); // Internet radio station name
			relationships[FrameTypes.INTERNET_RADIO_STATION_OWNER] = new Array(null, "TRSO", "TRSO"); // Internet radio station owner
			relationships[FrameTypes.ALBUM_SORT_ORDER] = new Array(null, null, "TSOA"); // Album sort order
			relationships[FrameTypes.PERFORMER_SORT_ORDER] = new Array(null, null, "TSOP"); // Performer sort order
			relationships[FrameTypes.TITLE_SORT_ORDER] = new Array(null, null, "TSOT"); // Title sort order
			relationships[FrameTypes.INTERNATIONAL_STANDARD_RECORDING_CODE] = new Array("TRC", "TSRC", "TSRC"); // ISRC (international standard recording code)
			relationships[FrameTypes.USED_FOR_ENCODING] = new Array("TSS", "TSSE", "TSSE"); // Software/Hardware and settings used for encoding
			relationships[FrameTypes.SET_SUBTITLE] = new Array(null, null, "TSST"); // Set subtitle
			//relationships[FrameTypes.RECORDING_DATES] = new Array("TRD", 0, 0);
			//relationships[FrameTypes.SIZE] = new Array("TSI", 0, 0);
			relationships[FrameTypes.YEAR] = new Array("TYE", "TYER", "TYER");
		}
		
		private function getFrameType(id:String, version:Number):uint {
			var v:uint = 1; //handler.versionIndex;
			switch(version){
				case 2.2:
					v = 0;
					break;
				case 2.3:
					v = 1;
					break;
				case 2.4:
					v = 2;
					break;
			}
			var result:uint = FrameTypes.UNKNOWN;
			for (var type:String in relationships){
				if(id==relationships[type][v]){	
					result = uint(type);
				}
			}
			return result;
		}
		
		override public function getSize(frame:Frame, version:Number):uint {
			if(frame is TFrame) {
				var tframe:TFrame = frame as TFrame;
				switch(version) {
					case 2.2:
						return 3 + 3 + tframe.text.length + 2;
						break;
					case 2.3:
						return 4 + 4 + tframe.text.length + 2;
						break;
				}
			}
			return 0;
		}
		
	}
}