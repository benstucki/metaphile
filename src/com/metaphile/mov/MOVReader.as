package com.metaphile.mov
{
import com.metaphile.IMetaReader;
import com.metaphile.MetaReaderBase;
import com.metaphile.logging.ParseLog;
import com.metaphile.mov.atoms.ISOCode;

import flash.events.EventDispatcher;
import flash.events.ProgressEvent;
//import flash.filesystem.FileStream;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.IDataInput;

public class MOVReader extends MetaReaderBase implements IMetaReader
{
	/**
	 * 	Internal data per stream request
	 */
	private var tags:Dictionary = new Dictionary(false);

	private var atomBufferSize:uint = 8;
	
	public function setIdentifier(stream:IDataInput, filename:String):void
	{
		tags[stream].filename = filename;
	}
	
	public function read(stream:IDataInput):void
	{
		tags[stream] = new ITunesData();
		tags[stream].nextAtomPosition = atomBufferSize;
		
		ParseLog.info(this, "## Start Reading #############################################");
		if (stream is EventDispatcher) 
		{
			(stream as EventDispatcher).addEventListener(ProgressEvent.PROGRESS, progressHandler);
		}
		if (stream.bytesAvailable > atomBufferSize) 
		{
			workStream(stream, stream.bytesAvailable, int.MAX_VALUE);
		}		
	}

	private function progressHandler(event:ProgressEvent):void 
	{
		workStream((event.target as IDataInput), event.bytesLoaded, event.bytesTotal);
	}	

	private function workStream(stream:IDataInput, bytesLoaded:int, bytesTotal:int):void 
	{
		ParseLog.info(this, "## workStream #############################################");

		var tag:ITunesData = tags[stream];
		var metaSize:int = (tag != null) ? tag.size : 0;
		var bytes:ByteArray = new ByteArray();
		// Read Atoms to try and find moov
		if (bytesLoaded >= tag.nextAtomPosition 
			&& tag.moovAtomPosition == 0) 
		{
			// read off old bytes
			if (tag.lastAtomPosition > 0)
				stream.readBytes(new ByteArray(), 0, tag.lastAtomSize-atomBufferSize);
				
			stream.readBytes(bytes, 0, tag.nextAtomPosition - tag.lastAtomPosition);				
	        var atomSize:Number = bytes.readUnsignedInt();
	        var atomCode:String = bytes.readUTFBytes(4);

	        if (ISOCode.isInvalidCode(atomCode) && tag.lastAtomPosition == 0) 
	        {
	        	// close stream 
				//if (stream is FileStream)
				//	(stream as FileStream).close();
				onMetaData(parseITunesTags(tagBytes, tag));
	        	return;
	        }
	        
	        if (atomCode == "moov")
	        {
	        	tag.moovAtomPosition = tag.lastAtomPosition;
	        	tag.size = atomSize;
	        }
	        
	        tag.lastAtomSize = atomSize;
	        tag.lastAtomPosition = tag.lastAtomPosition + atomSize;
	        tag.nextAtomPosition = tag.lastAtomPosition + atomBufferSize;
		}
		if (stream.bytesAvailable > tag.size
			&& bytesLoaded >= (tag.moovAtomPosition + tag.size)
			&& tag.moovAtomPosition > 0
			&& tag.size > 0) 
		{
			// moov atom
			stream.readBytes(bytes, 0, tag.size-atomBufferSize);
			bytes.position = 0;	
			
			// close stream 
			//if (stream is FileStream)
			//	(stream as FileStream).close();

			// Find udta atom
			var foundUdta:Boolean = false
			while (!foundUdta
				&& bytes.bytesAvailable > 0)
			{
		        var atomSize2:Number = bytes.readUnsignedInt();
		        var atomCode2:String = bytes.readUTFBytes(4);
		        if (atomCode2 == "udta")
		        {
		        	foundUdta = true;
		        }				
		        else
		        {
		        	if (atomSize2 > atomBufferSize)
		        		bytes.position += atomSize2 - atomBufferSize;
		        }
			}			
			// parse metadata
			bytes.position += 8 + 4 + 8 + 26;

			// Find udta atom
			var foundIlst:Boolean = false
			while (!foundIlst
				&& bytes.bytesAvailable > 0)
			{
		        var ilstSize:Number = bytes.readUnsignedInt();
		        var ilstCode:String = bytes.readUTFBytes(4);
		        if (ilstCode == "ilst")
		        {
		        	foundIlst = true;
		        }				
		        else
		        {
		        	if (ilstSize > atomBufferSize)
		        		bytes.position += ilstSize - atomBufferSize;
		        }
			}

			var tagBytes:ByteArray = new ByteArray();
			bytes.readBytes(tagBytes,0,ilstSize - 8);
			
			// Read tag info
			// Fire callback Function with data
			onMetaData(parseITunesTags(tagBytes, tag));		
						
		}		
	}

	private function parseITunesTags(bytes:ByteArray, tag:ITunesData):ITunesData
	{

		var count:int = 100;
		// Read Tag Information
		while (bytes.bytesAvailable
			&& count > 0)
		{
			// fail safe for now
			count--;
			
	        var tagSize:Number = bytes.readUnsignedInt();
	        var tagCode:String = bytes.readUTFBytes(4).toLowerCase();

	        var dataSize:Number = bytes.readUnsignedInt() - atomBufferSize - atomBufferSize;
	        var dataCode:String = bytes.readUTFBytes(4);
	        
	        // Tells you what type, we are hard coding below so no need to check
	        bytes.position += 8;
	        
	        switch (tagCode)
	        {
	        	case "©alb":
	        		bytes.readUTFBytes(dataSize);//tag.album = 
	        	break;
	        	case "©art":
	        		tag.artist = bytes.readUTFBytes(dataSize);
	        	break;
	        	case "aart":
	        		tag.albumArtist = bytes.readUTFBytes(dataSize);
	        	break;
	        	case "©cmt":
	        		bytes.readUTFBytes(dataSize);//tag.comment = 
	        	break;
	        	case "©day":
	        		tag.year = bytes.readUTFBytes(dataSize);
	        	break;
	        	case "©nam":
	        		tag.title = bytes.readUTFBytes(dataSize);
	        	break;
	        	case "tven":
	        		bytes.readUTFBytes(dataSize);//tag.episodeNumber = 
	        	break;
	        	case "tvsn":
	        		bytes.readUTFBytes(dataSize);//tag.showNumber = 
	        	break;
	        	case "covr":
	        		if (!tag.coverArts)
	        			tag.coverArts = new Array();
	        		var artBytes:ByteArray = new ByteArray();
	        		bytes.readBytes(artBytes, 0, dataSize);
	        		tag.coverArts.push(artBytes);
	        	break;
	        	default:
	        		bytes.position += tagSize - atomBufferSize - atomBufferSize - atomBufferSize;
	        	break;
	        }
		}	
		return tag;	
	}
	
}
}