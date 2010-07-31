package com.metaphile.mov
{
import com.metaphile.IMetaData;

import flash.events.EventDispatcher;
import flash.utils.ByteArray;

/**
 * Represents ID3 data, a format found in most MP3 files.
 * ID3 tags often contain information such as song title, album title, band name, and cover art.
 */
[Bindable] public class ITunesData extends EventDispatcher implements IMetaData
{
	
	//**********************************
	// Static Constants
	//**********************************
	
	public static const VERSION4_0:Number = 4.0;
	public static const VERSION4_2:Number = 4.2;
	public static const VERSION4_9:Number = 4.9;
	public static const VERSION5_0:Number = 5.0;
	public static const VERSION6_0:Number = 6.0;
	public static const VERSION7_0:Number = 7.0;
	
	
	//**********************************
	// Properties
	//**********************************


	public var size:Number = 0;
	public var moovAtomPosition:Number = 0;
	public var lastAtomSize:Number = 0;
	public var nextAtomPosition:Number = 0;
	public var lastAtomPosition:Number = 0;
	
	public var filename:String;
	
	public var album:String;
	public var artist:String;
	public var albumArtist:String;
	public var year:String;
	public var description:String;
	public var _title:String;
	public var coverArts:Array;
	
	public function set title(value:String):void
	{
		_title = value;
	}
	
	//*********************************
	// IMetaData Implementation
	//*********************************
	
	/**
	 * Song Title
	 */
	public function get title():String {
		if(_title) { return String(_title); }
		if(album) { return String(album); }
		return null;
	}
	
	/**
	 * Song description, album title, or group description.
	 */ 
	public function get subtitle():String {
		if(title) { return String(title); }
		if(album) { return String(album); }
		return null;
	}
	
	/**
	 * Band, performer, or composer homepage.
	 */
	public function get url():String { return ""; }
	public function get author():String {
		if(artist) { return String(artist); }
		if(albumArtist) { return String(albumArtist); }
		return null;
	}
	
	/**
	 * Album art.
	 */
	public function get image():ByteArray {
		if(coverArts && coverArts.length > 0) { return coverArts[0]; }
		return null;
	}
	
	/**
	 * Album art description.
	 */
	public function get imageDescription():String {
		if(description) { return description; }
		return null;
	}
	
	override public function toString():String
	{
		return "[artist: " + artist + 
			", title: " + title + 
			", filename: " + filename + "]";
	}
	
}
}