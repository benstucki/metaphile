/*********************************************************************************************************************************
 
 Copyright (c) 2007 Metaphile Contributors
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
 modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
*********************************************************************************************************************************/

package com.metaphile
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import com.metaphile.IMetaData;
	
	/**
	 * Defines the interface that metadata parsers must conform to for inclusion in the metaphile library.
	 */
	public interface IMetaReader
	{
		
		/**
		 * Determines if a stream is automatically closed after parsing or if it is left open for further use.
		 */
		function get autoClose():Boolean;
		function set autoClose(value:Boolean):void;
		
		/**
		 * Defines the maximum number of bytes to parse from a stream.
		 * Some metadata formats store information at various points in a file. This limit will prevent the parser from loading large files which may have metadata at the end.
		 * If autoClose is set to true, the stream will be closed after reaching this limit.
		 * If any metadata has been retrieved before the limit was reached, onComplete will still be called.
		 */
		function get autoLimit():int;
		function set autoLimit(value:int):void
		
		/**
		 * Defines a callback function which is called when metadata has been returned from a parser.
		 * The callback function must take IMetaData as it's first argument.
		 */
		function get onMetaData():Function;
		function set onMetaData(value:Function):void;
		/*
		function get onRefuse():Function;
		function set onRefuse(value:Function):void;
		*/
		
		/**
		 * Parses an open stream for metadata.
		 */
		function read( stream:IDataInput ):void;
		
	}
}