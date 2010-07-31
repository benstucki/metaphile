package com.metaphile.id3
{
	import com.metaphile.id3.frames.APICFrame;
	import com.metaphile.IMetaData;
	import flash.utils.ByteArray;
	import com.metaphile.id3.frames.Frame;
	import mx.collections.ArrayCollection;
	import com.metaphile.id3.frames.TFrame;
	import com.metaphile.id3.frames.FrameTypes;
	import flash.events.EventDispatcher;
	
	/**
	 * Represents ID3 data, a format found in most MP3 files.
	 * ID3 tags often contain information such as song title, album title, band name, and cover art.
	 */
	[Bindable] public class ID3Data extends EventDispatcher implements IMetaData
	{
		
		//**********************************
		// Static Constants
		//**********************************
		
		public static const VERSION1_0:Number = 1.0;
		public static const VERSION1_1:Number = 1.1;
		public static const VERSION2_2:Number = 2.2;
		public static const VERSION2_3:Number = 2.3;
		
		
		//**********************************
		// Property Backing Variables
		//**********************************
		
		private var _version:Number;
		private var _unsynchronisation:Boolean;
		private var _extended:Boolean;
		private var _experimental:Boolean;
		private var _size:int;
		private var _albumArt:APICFrame;
		private var _albumTitle:TFrame;
		private var _composers:TFrame;
		private var _genres:TFrame;
		private var _groupDescription:TFrame;
		private var _songTitle:TFrame;
		private var _songDescription:TFrame;
		private var _band:TFrame;
		private var _publisher:TFrame;
		private var _track:TFrame;
		private var _year:TFrame;
		private var _performer:TFrame;
		private var _privateFrames:Array;
		
		
		//**********************************
		// ID3 Properties
		//**********************************
		
		/**
		 * ID3 version number.
		 * Supported versions are 1.0, 1.1, 2.2, and 2.3.
		 */
		public function get version():Number { return _version; }
		public function set version( value:Number ):void {
			_version = value;
		}
		
		/**
		 * Indicates whether or not unsynchronisation is used.
		 * The only purpose of the 'unsynchronisation scheme' is to make the ID3v2 tag as compatible as possible with existing software.
		 * There is no use in 'unsynchronising' tags if the file is only to be processed by new software.
		 * Unsynchronisation may only be made with MPEG 2 layer I, II and III and MPEG 2.5 files.
		 */
		public function get unsynchronisation():Boolean { return _unsynchronisation; }
		public function set unsynchronisation(value:Boolean):void {
			_unsynchronisation = value;
		}
		
		/**
		 * Indicates whether or not the header is followed by an extended header.
		 * The extended header contains information that is not vital to the correct parsing of the tag information, hence the extended header is optional.
		 */
		public function get extended():Boolean { return _extended; }
		public function set extended(value:Boolean):void {
			_extended = value;
		}
		
		/**
		 * This flag should always be set when the tag is in an experimental stage.
		 */
		public function get experimental():Boolean { return _experimental; }
		public function set experimental(value:Boolean):void {
			_experimental = value;
		}
		
		/**
		 * The size of the ID3 tag in bytes.
		 * Note that this currently represents the number of bytes read from disk.
		 */
		public function get size():int { return _size; }
		public function set size(value:int):void {
			_size = value;
		}
		
		
		//*********************************
		// IMetaData Implementation
		//*********************************
		
		/**
		 * Song Title
		 */
		public function get title():String {
			if(songTitle) { return String(songTitle); }
			return null;
		}
		
		/**
		 * Song description, album title, or group description.
		 */ 
		public function get subtitle():String {
			if(songDescription) { return String(songDescription); }
			if(albumTitle) { return String(albumTitle); }
			if(groupDescription) { return String(groupDescription); }
			return null;
		}
		
		/**
		 * Band, performer, or composer homepage.
		 */
		public function get url():String { return ""; }
		public function get author():String {
			if(band) { return String(band); }
			if(performer) { return String(performer); }
			if(composers) { return String(composers); }
			return null;
		}
		
		/**
		 * Album art.
		 */
		public function get image():ByteArray {
			if(albumArt) { return albumArt.image; }
			return null;
		}
		
		/**
		 * Album art description.
		 */
		public function get imageDescription():String {
			if(albumArt) { return albumArt.description; }
			return null;
		}
		
		
		//*****************************************
		// ID3 Frames
		//*****************************************
		
		/**
		 * A picture directly related to the audio file.
		 */
		public function get albumArt():APICFrame { return _albumArt; }
		public function set albumArt( value:APICFrame ):void {
			_albumArt = value;
		}
		
		/**
		 * The title of the recording which the audio in the file is taken from.
		 */
		public function get albumTitle():TFrame { return _albumTitle; }
		public function set albumTitle( value:TFrame ):void {
			_albumTitle = value;
		}
		
		private var _bpm:uint; // todo: implement bpm
		
		/**
		 * The name of the composer(s). They are seperated with the "/" character.
		 */
		public function get composers():TFrame { return _composers; }
		public function set composers( value:TFrame ):void {
			_composers = value;
		}
		
		private var _copyright:String;
		private var _date:Date;
		private var _playlistDelay:Number;
		private var _encodedBy:String;
		private var _lyricists:Array;
		private var _fileType:String;
		private var _time:Date;
		
		/**
		 * Song genre.
		 */
		public function get genres():TFrame { return _genres; }
		public function set genres( value:TFrame ):void {
			_genres = value;
		}
		
		/**
		 * Used if the sound belongs to a larger category of sounds/music. For example, classical music is often sorted in different musical sections (e.g. "Piano Concerto", "Weather - Hurricane").
		 */
		public function get groupDescription():TFrame { return _groupDescription; }
		public function set groupDescription( value:TFrame ):void {
			_groupDescription = value;
		}
		
		/**
		 * The actual name of the piece (e.g. "Adagio", "Hurricane Donna").
		 */
		public function get songTitle():TFrame { return _songTitle; }
		public function set songTitle( value:TFrame ):void {
			_songTitle = value;
		}
		
		/**
		 * Used for information directly related to the contents title (e.g. "Op. 16" or "Performed live at Wembley").
		 */
		public function get songDescription():TFrame { return _songDescription; }
		public function set songDescription( value:TFrame ):void {
			_songDescription = value;
		}
		
		private var _key:String;
		private var _languages:Array;
		private var _length:Number;
		private var _mediaType:Array;
		private var _originalAlbum:String;
		private var _originalFilename:String;
		private var _originalLyricists:Array;
		private var _originalPerformers:Array;
		private var _originalReleaseYear:int;
		private var _fileOwner:String;
		private var _performers:Array;
		
		/**
		 * The band, orchestra, or accompaniment in the recording. 
		 */
		public function get band():TFrame { return _band; }
		public function set band( value:TFrame ):void {
			_band = value;
		}
		
		private var _conductor:String;
		private var _modifiedBy:String;
		private var _partOfSet:String;
		
		/**
		 * The name of the label or publisher.
		 */
		public function get publisher():TFrame { return _publisher; }
		public function set publisher( value:TFrame ):void {
			_publisher = value;
		}
		
		/**
		 * A numeric string containing the order number of the audio-file on its original recording.
		 * This may be extended with a "/" character and a numeric string containing the total numer of tracks/elements on the original recording. E.g. "4/9".
		 */
		public function get track():TFrame { return _track; }
		public function set track( value:TFrame ):void {
			_track = value;
		}
		
		private var _recordingDates:String;
		private var _internetRadioStationName:String;
		private var _internetRadioStationOwner:String;
		//private var _size:int;
		private var _isrc:String;
		private var _encodingSoftware:String;
		
		/**
		 * A numeric string with a year of the recording.
		 * This frames is always four characters long (until the year 10000).
		 */
		public function get year():TFrame { return _year; }
		public function set year( value:TFrame ):void {
			_year = value;
		}
		
		private var _userDefined:Array;
		private var _commercialURI:Array;
		private var _copyrightURI:String;
		private var _officialAudioFileWebpage:String;
		private var _officialArtistWebpages:Array;
		private var _officialAudioSourceWebpage:String;
		private var _officialInternetRadioStationWebpage:String;
		private var _officialPaymentWebpage:String;
		private var _officialPublishersWebpage:String;
		private var _userDefinedURI:Array;
		
		/**
		 * Used for the main artist(s).
		 * They are seperated with the "/" character.
		 */
		public function get performer():TFrame { return _performer; }
		public function set performer(value:TFrame):void {
			_performer = value;
		}
		
		/**
		 * Frames used to contain information from a software producer that its program uses and does not fit into the other frames.
		 */
		public function get privateFrames():Array { return _privateFrames; }
		public function set privateFrames( value:Array ):void {
			_privateFrames = value;
		}
		
		public function ID3Data() {
			privateFrames = new Array();
		}
		
		public function addFrame( frame:Frame ):void {
			switch(frame.type) {
				case FrameTypes.ALBUM_TITLE:
					_albumTitle = TFrame(frame);
					break;
				case FrameTypes.CONTENT_GROUP_DESCRIPTION:
					_groupDescription = TFrame(frame);
				case FrameTypes.TITLE:
					_songTitle = TFrame(frame);
					break;
				case FrameTypes.SUBTITLE:
					_songDescription = TFrame(frame);
					break;
				case FrameTypes.ATTACHED_PICTURE:
					_albumArt = APICFrame(frame);
					break;
				case FrameTypes.TRACK_NUMBER:
					_track = TFrame(frame);
					break;
				case FrameTypes.YEAR:
					_year = TFrame(frame);
					break;
				case FrameTypes.PUBLISHER:
					_publisher = TFrame(frame);
					break;
				case FrameTypes.PRIVATE_FRAME:
					_privateFrames.push(frame);
					break;
				case FrameTypes.BAND:
					_band = TFrame(frame);
					break;
				case FrameTypes.LEAD_PERFORMER:
					_performer = TFrame(frame);
					break;
				case FrameTypes.COMPOSER:
					_composers = TFrame(frame);
					break;
				case FrameTypes.CONTENT_TYPE:
					_genres = TFrame(frame);
					break;
			}
		}
		
	}
}