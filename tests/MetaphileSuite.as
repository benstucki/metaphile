package
{
	import com.metaphile.id3.PictureTest;
	
	import mx.logging.ILoggingTarget;
	import mx.logging.Log;
	import mx.logging.targets.TraceTarget;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class MetaphileSuite
	{
		
		
		[BeforeClass]
		static public function setup():void {
			var logger:ILoggingTarget = new TraceTarget();
			Log.addTarget(logger);
		}
		
		public var test:PictureTest;
		
	}
}