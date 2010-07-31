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
	
	/**
	 * Defines the interface that metadata objects must conform to for inclusion in the metaphile library.
	 * Classes which implement IMetaData may define additional properties and methods which are specific to the file format they represent.
	 * If a metadata property is not available, it should be set to null.
	 */
	public interface IMetaData
	{
		
		/**
		 * The title which best represents a file.
		 */
		function get title():String;
		
		/**
		 * The subtitle, context information, or brief description of a file.
		 */
		function get subtitle():String;
		
		/**
		 * The author or creator of content in a file.
		 */
		function get author():String;
		
		/**
		 * The thumbnail image which best represents a file.
		 */
		function get image():ByteArray;
		
	}
}