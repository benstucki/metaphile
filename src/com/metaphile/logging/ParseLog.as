package com.metaphile.logging
{
	import flash.utils.*;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class ParseLog
	{
		
		public static const DEBUG:Boolean = true;
		private static var parseLogger:ILogger = Log.getLogger("ParseLog");
		
		public static function parsed( source:Object, msg:String, value:Object, position:Number ):void {
			//var logger:ILogger = Log.getLogger(getQualifiedCategoryName(source));
			if(DEBUG) {
				msg = msg.replace(new RegExp("\\{0\\}", "g"), value.toString());
				msg = "// " + padString(msg) + position;
				parseLogger.info(msg);
			}
		}
		
		public static function info( source:Object, msg:String, ... rest ):void {
			var logger:ILogger = Log.getLogger(getQualifiedCategoryName(source));
			logger.info(msg, rest);
		}
		
		public static function debug( source:Object, msg:String, ... rest ):void {
			var logger:ILogger = Log.getLogger(getQualifiedCategoryName(source));
			logger.debug(msg, rest);
		}
		
		public static function warn( source:Object, msg:String, ... rest ):void {
			var logger:ILogger = Log.getLogger(getQualifiedCategoryName(source));
			logger.warn(msg, rest);
		}
		
		private static function padString( s:String, symbol:String = " ", padLength:uint = 60 ):String {
			while(s.length < padLength) {
				s += symbol;
			}
			return s;
		}
		
		private static function getQualifiedCategoryName(object:Object):String {
			return flash.utils.getQualifiedClassName(object).replace("::", ".");
		}
		
	}
}