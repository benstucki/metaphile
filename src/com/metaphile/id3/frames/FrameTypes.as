package com.metaphile.id3.frames
{
	public class FrameTypes
	{
		
		public static const UNKNOWN:uint = 0;
		public static const AUDIO_ENCRYPTION:uint = 1; // Audio encryption
		public static const ATTACHED_PICTURE:uint = 2; // Attached picture
		public static const AUDIO_SEEK_POINT_INDEX:uint = 3; // Audio seek point index

		public static const COMMENTS:uint = 4; // Comments
		public static const COMMERCIAL_FRAME:uint = 5; // Commercial frame

		public static const ENCRYPTION_METHOD_REGISTRATION:uint = 6; // Encryption method registration
		public static const EQUALISATION:uint = 7; // Equalisation (2)
		public static const EVENT_TIMING_CODES:uint = 8; // Event timing codes

		public static const GENERAL_ENCAPSULATED_OBJECT:uint = 9; // General encapsulated object
		public static const GROUP_IDENTIFICATION_REGISTRATION:uint = 10; // Group identification registration

		public static const LINKED_INFORMATION:uint = 11; // Linked information

		public static const MUSIC_CD_IDENTIFIER:uint = 12; // Music CD identifier
		public static const MPEG_LOCATION_LOOKUP_TABLE:uint = 13; // MPEG location lookup table

		public static const OWNERSHIP_FRAME:uint = 14; // Ownership frame

		public static const PRIVATE_FRAME:uint = 15; // Private frame
		public static const PLAY_COUNTER:uint = 16; // Play counter
		public static const POPULARIMETER:uint = 17; // Popularimeter
		public static const POSITION_SYNCHRONISATION:uint = 18; // Position synchronisation frame
		public static const RECOMMENDED_BUFFER_SIZE:uint = 19; // Recommended buffer size
		public static const RELATIVE_VOLUME_ADJUSTMENT:uint = 20; // Relative volume adjustment (2)
		public static const REVERB:uint = 21; // Reverb

		public static const SEEK_FRAME:uint = 22; // Seek frame
		public static const SIGNATURE_FRAME:uint = 23; // Signature frame
		public static const SYNCHRONIZED_LYRICS:uint = 24; // Synchronised lyric/text
		public static const SYNCHRONIZED_TEMPO_CODES:uint = 25; // Synchronised tempo codes

		public static const ALBUM_TITLE:uint = 26; // Album/Movie/Show title
		public static const BPM:uint = 27; // BPM (beats per minute)
 		public static const COMPOSER:uint = 28; // Composer
		public static const CONTENT_TYPE:uint = 29; // Content type
		public static const COPYRIGHT_MESSAGE:uint = 30; // Copyright message
		public static const ENCODING_TIME:uint = 31; // Encoding time
		public static const PLAYLIST_DELAY:uint = 32; // Playlist delay
		public static const ORIGINAL_RELEASE_TIME:uint = 33; // Original release time
		public static const RECORDING_TIME:uint = 34; // Recording time
		public static const RELEASE_TIME:uint = 35; // Release time
		public static const TAGGING_TIME:uint = 36; // Tagging time
		public static const ENCODED_BY:uint = 37; // Encoded by
		public static const LYRICIST:uint = 38; // Lyricist/Text writer
		public static const FILE_TYPE:uint = 39; // File type
		public static const INVOLVED_PEOPLE_LIST:uint = 40; // Involved people list
		public static const CONTENT_GROUP_DESCRIPTION:uint = 41; // Content group description
		public static const TITLE:uint = 42; // Title/songname/content description
		public static const SUBTITLE:uint = 43; // Subtitle/Description refinement
		public static const INITIAL_KEY:uint = 44; // Initial key
		public static const LANGUAGE:uint = 45; // Language(s)
		public static const LENGTH:uint = 46; // Length
		public static const MUSICIAN_CREDITS_LIST:uint = 47; // Musician credits list
		public static const MEDIA_TYPE:uint = 48; // Media type
		public static const MOOD:uint = 49; // Mood
		public static const ORIGINAL_ALBUM:uint = 50; // Original album/movie/show title
		public static const ORIGINAL_FILENAME:uint = 51; // Original filename
		public static const ORIGINAL_LYRICIST:uint = 52; // Original lyricist(s)/text writer(s)
		public static const ORIGINAL_ARTIST:uint = 53; // Original artist(s)/performer(s)
		public static const FILE_OWNER:uint = 54; // File owner/licensee
		public static const LEAD_PERFORMER:uint = 55; // Lead performer(s)/Soloist(s)
		public static const BAND:uint = 56; // Band/orchestra/accompaniment
		public static const CONDUCTOR:uint = 57; // Conductor/performer refinement
		public static const INTERPRETED_BY:uint = 58; // Interpreted, remixed, or otherwise modified by
		public static const PART_OF_SET:uint = 59; // Part of a set
		public static const PRODUCED_NOTICE:uint = 60; // Produced notice
		public static const PUBLISHER:uint = 61; // Publisher
		public static const TRACK_NUMBER:uint = 62; // Track number/Position in set
		public static const INTERNET_RADIO_STATION_NAME:uint = 63; // Internet radio station name
		public static const INTERNET_RADIO_STATION_OWNER:uint = 64; // Internet radio station owner
		public static const ALBUM_SORT_ORDER:uint = 65; // Album sort order
		public static const PERFORMER_SORT_ORDER:uint = 66; // Performer sort order
		public static const TITLE_SORT_ORDER:uint = 67; // Title sort order
		public static const INTERNATIONAL_STANDARD_RECORDING_CODE:uint = 68; // ISRC (international standard recording code)
		public static const USED_FOR_ENCODING:uint = 69; // Software/Hardware and settings used for encoding
		public static const YEAR:uint = 70;
		public static const SET_SUBTITLE:uint = 71; // Set subtitle
		public static const USER_DEFINED_TEXT_INFORMATION:uint = 72; // User defined text information frame
		
		public static const UNIQUE_FILE_IDENTIFIER:uint = 73; // Unique file identifier
		public static const TERMS_OF_USE:uint = 74; // Terms of use
		public static const UNSYNCHRONISED_LYRICS:uint = 75; // Unsynchronised lyric/text transcription
		
		public static const COMMERCIAL_URI:uint = 76; // Commercial information
		public static const COPYRIGHT_URI:uint = 77; // Copyright/Legal information
		public static const AUDIO_URI:uint = 78; // Official audio file webpage
		public static const ARTIST_URI:uint = 79; // Official artist/performer webpage
 		public static const AUDIO_SOURCE_URI:uint = 80; // Official audio source webpage
		public static const INTERNET_RADIO_STATION_URI:uint = 81; // Official Internet radio station homepage
		public static const PAYMENT_URI:uint = 82; // Payment
		public static const PUBLISHERS_URI:uint = 83; // Publishers official webpage
		public static const USER_DEFINED_URI:uint = 84; // User defined URL link frame
		/*
		public static const FRAMESV2x4:Array = new Array(
		"UNKOWN",
		"AENC", 
		"APIC", 
		"ASPI", 
		"COMM", 
		"COMR", 
		"ENCR", 
		"EQU2", 
		"ETCO", 
		"GEOB", 
		"GRID", 
		"LINK", 
		"MCDI", 
		"MLLT", 
		"OWNE", 
		"PRIV", 
		"PCNT", 
		"POPM", 
		"POSS", 
		"RBUF", 
		"RVA2", 
		"RVRB", 
		"SEEK", 
		"SIGN", 
		"SYLT", 
		"SYTC", 
		"TALB", 
		"TBPM", 
		"TCOM", 
		"TCON", 
		"TCOP", 
		"TDEN", 
		"TDLY", 
		"TDOR", 
		"TDRC", 
		"TDRL", 
		"TDTG", 
		"TENC", 
		"TEXT", 
		"TFLT", 
		"TIPL", 
		"TIT1", 
		"TIT2", 
		"TIT3", 
		"TKEY", 
		"TLAN", 
		"TLEN", 
		"TMCL", 
		"TMED", 
		"TMOO", 
		"TOAL", 
		"TOFN", 
		"TOLY", 
		"TOPE", 
		"TOWN", 
		"TPE1", 
		"TPE2", 
		"TPE3", 
		"TPE4", 
		"TPOS", 
		"TPRO", 
		"TPUB", 
		"TRCK", 
		"TRSN", 
		"TRSO", 
		"TSOA", 
		"TSOP", 
		"TSOT", 
		"TSRC", 
		"TSSE", 
		"TSST", 
		"TXXX", 
		"UFID", 
		"USER", 
		"USLT", 
		"WCOM", 
		"WCOP", 
		"WOAF", 
		"WOAR", 
		"WOAS", 
		"WORS", 
		"WPAY", 
		"WPUB", 
		"WXXX"
		);
		
		public static const FRAMESV2x3:Array = new Array(
		"UNKOWN",
		"AENC", 
		"APIC", 
		null, 
		"COMM", 
		"COMR", 
		"ENCR", 
		"EQUA", 
		"ETCO", 
		"GEOB", 
		"GRID", 
		"LINK", 
		"MCDI", 
		"MLLT", 
		"OWNE", 
		"PRIV", 
		"PCNT", 
		"POPM", 
		"POSS", 
		"RBUF", 
		"RVAD", 
		"RVRB", 
		null, 
		null, 
		"SYLT", 
		"SYTC", 
		"TALB", 
		"TBPM", 
		"TCOM", 
		"TCON", 
		"TCOP",
		null, //TDAT
		"TDLY", 
		null, 
		null, 
		null, 
		null, 
		"TENC", 
		"TEXT", 
		"TFLT", 
		null, //TIME
		"TIT1", 
		"TIT2", 
		"TIT3", 
		"TKEY", 
		"TLAN", 
		"TLEN", 
		null, 
		"TMED", 
		null, 
		"TOAL", 
		"TOFN", 
		"TOLY", 
		"TOPE", // TORY
		"TOWN", 
		"TPE1", 
		"TPE2", 
		"TPE3", 
		"TPE4", 
		"TPOS", 
		null, 
		"TPUB", 
		"TRCK", // TRDA
		"TRSN", 
		"TRSO", 
		null, 
		null, 
		null, 
		"TSRC", 
		"TSSE", 
		null, 
		"TXXX", 
		"UFID", 
		"USER", 
		"USLT", 
		"WCOM", 
		"WCOP", 
		"WOAF", 
		"WOAR", 
		"WOAS", 
		"WORS", 
		"WPAY", 
		"WPUB", 
		"WXXX"
		);
		*/
	}
}