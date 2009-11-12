package AutumnFall.Gui.Balloons.Error 
{
	import AutumnFall.Gui.Balloons.SimpleTailBalloon;
	import AutumnFall.Utils.Colors;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * The Base Erro Balloon used in Forms.
	 */
	public class BaseErrorBalloon extends SimpleTailBalloon
	{
		/**
		 * Consructor.
		 * @param	content The contents of the ballon.
		 * @param	tailPoint Where do you want the tail to end?
		 */
		public function BaseErrorBalloon(content:MovieClip, tailPoint:Point) 		
		{	
			//Call daddy with the new content.
			super(content, tailPoint, Colors.RED, Colors.DARK_RED, 1, Colors.BLACK);
		}
		
	}
	
}