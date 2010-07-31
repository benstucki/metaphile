package com.metaphile
{
	import flash.utils.ByteArray;
	
	public interface IMetaWriter
	{
		
		//function set writers(value:Array):void;
		function encode( meta:IMetaData ):ByteArray;
		
	}
}