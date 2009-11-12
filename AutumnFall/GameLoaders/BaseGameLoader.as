package AutumnFall.GameLoaders
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import AutumnFall.GameLoader;
	import flash.geom.Rectangle;
	
	
	/**
	 * Basic Loader MovieClip class
	 */
	public class BaseGameLoader extends GameLoader
	{
		//Stage
		public var upperFrame:MovieClip;
		public var lowerFrame:MovieClip;
		
		public function BaseGameLoader()
		{
			this.gameArea = new Rectangle(0, 30, 700, 450);
			super();
		}
	}
}