package com.metaphile.mov.atoms
{

/**
 * 	The atom ISO Code and where it is located in the file
 * 
 */
public class ISOCode
{

    //--------------------------------------------------------------------------
    //
    //  Constants
    //
    //--------------------------------------------------------------------------

	public static const FREE_ATOM:String = "free";
	public static const JUNK_ATOM:String = "junk";
	public static const MDAT_ATOM:String = "mdat";
	public static const MOOV_ATOM:String = "moov";
	public static const PNOT_ATOM:String = "pnot";
	public static const SKIP_ATOM:String = "skip";
	public static const WIDE_ATOM:String = "wide";
	public static const PICT_ATOM:String = "PICT";
	public static const FTYP_ATOM:String = "ftyp";
	
	// ISO family codes
	public static const BXML_ATOM:String = "bxml";
	public static const CO64_ATOM:String = "co64";
	public static const CPRT_ATOM:String = "cprt";
	public static const CTTS_ATOM:String = "ctts";
	public static const IINF_ATOM:String = "iinf";
	public static const ILOC_ATOM:String = "iloc";
	public static const META_ATOM:String = "meta";
	public static const TRAK_ATOM:String = "trak";
	public static const TKHD_ATOM:String = "tkhd";
	public static const STCO_ATOM:String = "stco";
	public static const CMOV_ATOM:String = "cmov";
	public static const UDTA_ATOM:String = "udta";
	public static const ILST_ATOM:String = "ilst";
	public static const MDIA_ATOM:String = "mdia";
	public static const STBL_ATOM:String = "stbl";
	public static const MVHD_ATOM:String = "mvhd";
	public static const MINF_ATOM:String = "minf";
	public static const URL_ATOM:String = "url ";

	public static function isInvalidCode(code:String):Boolean
	{
		 return ((code != ISOCode.FREE_ATOM) &&
            (code != ISOCode.JUNK_ATOM) &&
            (code != ISOCode.MDAT_ATOM) &&
            (code != ISOCode.MOOV_ATOM) &&
            (code != ISOCode.PNOT_ATOM) &&
            (code != ISOCode.SKIP_ATOM) &&
            (code != ISOCode.WIDE_ATOM) &&
            (code != ISOCode.PICT_ATOM) &&
            (code != ISOCode.FTYP_ATOM));
	}
	public static function isCharacterCode(code:String):Boolean
	{
		var exp:RegExp = /[@a-zA-Z][a-zA-Z0-9][a-zA-Z0-9 ][a-zA-Z0-9 ]/;
		return (code.search(exp) > -1);
	}
	/*
		NOT Complete hard to get info on this for sure
	public static function isValidMetaContainer(code:String):Boolean
	{
		 return ((code == ISOCode.TRAK_ATOM) ||
            (code == ISOCode.ILST_ATOM) ||
            (code == ISOCode.UDTA_ATOM) ||
            (code == ISOCode.STBL_ATOM) ||
            (code == ISOCode.MDIA_ATOM) ||
            (code == ISOCode.META_ATOM) ||
            (code == ISOCode.MVHD_ATOM) ||
            (code == ISOCode.MOOV_ATOM) ||
            (code == ISOCode.MINF_ATOM));
	}	
	*/

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------
	
	public function ISOCode()
	{
	}
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    //  code
    //--------------------------------------------------------------------------
    
	private var _code:String;
	/**
	 * 	The ATOM type or ISO code of the atom, ie: moov, ftyp, mdat etc...
	 */
	public function get code():String
	{
		return _code;	
	}
	/**
	 * 	@private
	 */
	public function set code(value:String):void
	{
		_code = value;
	}


    //--------------------------------------------------------------------------
    //  size
    //--------------------------------------------------------------------------
    
	private var _size:Number = 0;
	/**
	 * 	The ATOM size
	 */
	public function get size():Number
	{
		return _size;	
	}
	/**
	 * 	@private
	 */
	public function set size(value:Number):void
	{
		_size = value;
		if (value == 1)
			is64 = true;
	}

    //--------------------------------------------------------------------------
    //  offset
    //--------------------------------------------------------------------------
    
	private var _offset:Number = 0;
	/**
	 * 	The byte offset of where the ATOM resides in the file
	 */
	public function get offset():Number
	{
		return _offset;	
	}
	/**
	 * 	@private
	 */
	public function set offset(value:Number):void
	{
		_offset = value;
	}

    //--------------------------------------------------------------------------
    //  is64
    //--------------------------------------------------------------------------
    
	public var is64:Boolean = false;
    
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------
    
    public function toString():String
    {
    	return "[code: " + code + ",size: " + size + ",offset: " + offset + "]";
    }
	

}
}